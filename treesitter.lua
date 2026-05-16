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

  vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('OwenTreesitter', { clear = true }),
    pattern = languages,
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
