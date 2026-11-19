-- AI tab completion via minuet-ai.nvim.
--
-- Default: Qwen3 Coder Next through OpenRouter as a real fill-in-the-middle
-- (FIM) model (OPENROUTER_NVIM_API_KEY). It sees the code before AND after the
-- cursor and only generates the gap, so it stops where the existing code
-- resumes instead of rewriting it.
--
-- OpenRouter's /completions endpoint drops the standard `suffix` field, so the
-- prompt is built with Qwen's own FIM tokens. That only works on hosts that
-- pass the raw prompt through, hence the pinned provider below.
--
-- Switchable chat fallbacks (`:Minuet change_provider <name>`):
--   claude            Claude Haiku on ANTHROPIC_NVIM_API_KEY
--   openai_compatible DeepSeek V4 Flash through OpenRouter
-- Back to the default: `:Minuet change_provider openai_fim_compatible`.
-- Check the active one: `:lua print(require('minuet').config.provider)`.

-- Read a key from the environment, falling back to ~/.zshenv so it works
-- even when Neovim was started from a shell that predates the export.
local function env_key(name)
  return function()
    local key = vim.env[name]
    if key and key ~= '' then
      return key
    end
    local f = io.open(vim.fn.expand('~/.zshenv'), 'r')
    if not f then
      return nil
    end
    for line in f:lines() do
      local v = line:match('^%s*export%s+' .. name .. '=["\']?([^"\'%s]+)')
      if v then
        key = v
      end
    end
    f:close()
    if key then
      vim.env[name] = key
    end
    return key
  end
end

-- FIM output cleanup: drop any leaked special tokens and trailing blank
-- space, so accepting never adds a stray empty line.
local function fim_text(json)
  local text = json.choices[1].text or ''
  text = text:gsub('<|[%w_]+|>', '')
  -- Drop stray markdown fences / backticks the model sometimes emits.
  text = text:gsub('```%w*', ''):gsub('^`+', ''):gsub('`+$', '')
  return (text:gsub('%s+$', ''))
end

-- Chat models (Claude/DeepSeek) get one completion only. Minuet's default
-- prompt explicitly asks for "multiple completion options" separated by
-- <endCompletion> and its few-shot example shows two, which is where the
-- (1/2), (1/3) cycling came from. This prompt asks for one, short, and the
-- <endCompletion> stop sequence cuts generation off after the first anyway.
local chat_system = {
  template = '{{{prompt}}}\n{{{guidelines}}}',
  prompt = [[
You are a code completion engine inside an editor, like inline autocomplete.
You receive the code after the cursor (<contextAfterCursor>) and the code
before the cursor (<contextBeforeCursor>, ending at <cursorPosition>).
Return ONLY the exact text to insert at <cursorPosition>.]],
  guidelines = [[
Rules:
1. Return exactly ONE completion, then <endCompletion>. Never offer alternatives.
2. Prefer finishing the current line or statement. Only continue onto further
   lines when the current block is clearly unfinished, and stop where the code
   after the cursor takes over. Never repeat code that is already after the cursor.
3. The result must be syntactically valid once the code after the cursor is
   appended directly behind it (no duplicated closing brackets, semicolons or quotes).
4. Keep the user's indentation. Do not re-indent the text before the cursor.
5. No explanations, no markdown, no code fences.]],
}

local chat_few_shots = {
  {
    role = 'user',
    content = [[
# language: javascript
<contextAfterCursor>
    }
    return result;
}
<contextBeforeCursor>
function transformData(data, options) {
    const result = [];
    for (const item of data) {
        if (options.uppercase) {
            result.push(<cursorPosition>]],
  },
  {
    role = 'assistant',
    content = 'item.toUpperCase());\n        } else {\n            result.push(item);\n        }<endCompletion>',
  },
}

require('minuet').setup({
  provider = 'openai_fim_compatible',
  request_timeout = 3,
  throttle = 800,
  debounce = 200,
  n_completions = 1,
  context_window = 32000,
  context_ratio = 0.6,
  -- Trim any overlap with the code after/before the cursor, even 1 char,
  -- so accepted suggestions don't duplicate existing rows.
  after_cursor_filter_length = 1,
  before_cursor_filter_length = 1,
  provider_options = {
    openai_fim_compatible = {
      name = 'OpenRouter FIM',
      end_point = 'https://openrouter.ai/api/v1/completions',
      api_key = env_key('OPENROUTER_NVIM_API_KEY'),
      model = 'qwen/qwen3-coder-next',
      stream = false,
      template = {
        prompt = function(before, after, _)
          return '<|fim_prefix|>' .. before .. '<|fim_suffix|>' .. after .. '<|fim_middle|>'
        end,
        -- OpenRouter ignores `suffix`; it's already inside the prompt above.
        suffix = false,
      },
      get_text_fn = { no_stream = fim_text },
      optional = {
        max_tokens = 128,
        temperature = 0.1,
        stop = { '<|endoftext|>', '<|fim_pad|>', '<|file_sep|>', '<|im_end|>', '\n\n\n' },
        -- Parasail passes the raw FIM prompt through (bf16). Other hosts may
        -- wrap it in a chat template, which breaks FIM, so no fallbacks.
        provider = { order = { 'Parasail' }, allow_fallbacks = false },
      },
    },
    openai_compatible = {
      name = 'OpenRouter',
      end_point = 'https://openrouter.ai/api/v1/chat/completions',
      api_key = env_key('OPENROUTER_NVIM_API_KEY'),
      model = 'deepseek/deepseek-v4-flash',
      system = chat_system,
      few_shots = chat_few_shots,
      optional = {
        max_tokens = 128,
        temperature = 0.1,
        stop = { '<endCompletion>' },
        provider = { sort = 'throughput' },
        reasoning_effort = 'none',
      },
    },
    claude = {
      model = 'claude-haiku-5-5',
      max_tokens = 96,
      api_key = env_key('ANTHROPIC_NVIM_API_KEY'),
      system = chat_system,
      few_shots = chat_few_shots,
      optional = {
        stop_sequences = { '<endCompletion>' },
        thinking = { type = 'disabled' },
      },
    },
  },
  virtualtext = {
    auto_trigger_ft = { '*' },
    auto_trigger_ignore_ft = { 'TelescopePrompt', 'NvimTree', 'lazy', 'gitcommit' },
    keymap = {
      accept = nil, -- <Tab> below
      accept_line = '<A-a>',
      accept_n_lines = '<A-z>',
      prev = '<A-[>',
      next = '<A-]>',
      dismiss = '<A-e>',
    },
    show_on_completion_menu = true,
  },
})

-- <Tab> accepts the ghost text when one is showing, otherwise inserts a normal tab.
local vt = require('minuet.virtualtext')
vim.keymap.set('i', '<Tab>', function()
  if vt.action.is_visible() then
    vt.action.accept()
    return ''
  end
  return '<Tab>'
end, { expr = true, silent = true, desc = 'Accept minuet suggestion' })
