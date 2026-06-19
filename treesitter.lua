local languages = {
  'bash',
  'c',
  'css',
  'html',
  'javascript',
  'json',
  'jsonc',
  'lua',
  'markdown',
  'markdown_inline',
  'php',
  'python',
  'query',
  'toml',
  'tsx',
  'typescript',
  'vim',
  'vimdoc',
  'vue',
  'yaml',
}

local filetypes = {
  'bash',
  'c',
  'css',
  'html',
  'javascript',
  'javascriptreact',
  'json',
  'jsonc',
  'lua',
  'markdown',
  'markdown_inline',
  'php',
  'python',
  'query',
  'toml',
  'tsx',
  'typescript',
  'typescriptreact',
  'vim',
  'vimdoc',
  'vue',
  'yaml',
}

local language_by_filetype = {
  javascriptreact = 'javascript',
  typescriptreact = 'tsx',
}

local indent_disabled = {
  python = true,
  yaml = true,
}

local function setup_main()
  local ok, treesitter = pcall(require, 'nvim-treesitter')
  if not ok or type(treesitter.setup) ~= 'function' then
    return false
  end

  treesitter.setup({
    install_dir = vim.fn.stdpath('data') .. '/site',
  })

  for filetype, language in pairs(language_by_filetype) do
    vim.treesitter.language.register(language, filetype)
  end

  vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('OwenTreesitter', { clear = true }),
    pattern = filetypes,
    callback = function(args)
      pcall(vim.treesitter.start, args.buf)

      local filetype = vim.bo[args.buf].filetype
      if not indent_disabled[filetype] then
        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    end,
  })

  return true
end

local function setup_legacy()
  local ok, configs = pcall(require, 'nvim-treesitter.configs')
  if not ok then
    return
  end

  configs.setup({
    indent = { enable = true, disable = { 'yaml', 'python' } },
    highlight = {
      enable = true,
    },
  })
end

if not setup_main() then
  setup_legacy()
end
