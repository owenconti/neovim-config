local vim = vim

require('mason').setup()

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Oxlint (replaces ESLint for JS/TS/Vue; aligns with oxc.oxc-vscode + source.fixAll.oxc).
vim.lsp.config('oxlint', {
  capabilities = capabilities,
})

vim.lsp.config('ts_ls', {
  capabilities = capabilities,
  filetypes = { 'typescript', 'typescriptreact', 'typescript.tsx' },
  cmd = { 'typescript-language-server', '--stdio' },
})

vim.lsp.config('volar', {
  capabilities = capabilities,
  filetypes = { 'vue' },
  init_options = {
    vue = {
      hybridMode = false,
    },
  },
})

vim.lsp.config('tailwindcss', {
  capabilities = capabilities,
  settings = {
    tailwindCSS = {
      files = {
        exclude = { 'node_modules', '.git', '.cache', 'vendor', 'public', 'storage', 'bootstrap' },
      },
    },
  },
})

vim.lsp.config('stylelint_lsp', {
  capabilities = capabilities,
  settings = {
    stylelintplus = {
      autoFixOnSave = true,
      autoFixOnFormat = true,
    },
  },
  filetypes = { 'css' },
})

-- Match Diagonal `.vscode/settings.json` (intelephense): PHP 8.4.x, no built-in format (pint via run-on-save).
vim.lsp.config('intelephense', {
  capabilities = capabilities,
  settings = {
    intelephense = {
      environment = {
        phpVersion = '8.4.19',
      },
      format = {
        enable = false,
      },
    },
  },
  init_options = {
    licenseKey = os.getenv('INTELEPHENSE_LICENSE_KEY'),
  },
})

-- Filetypes where Oxfmt handles formatting (see conform.nvim); skip LSP BufWritePre format to avoid fighting ts_ls.
local conform_oxfmt_ft = {
  typescript = true,
  typescriptreact = true,
  javascript = true,
  javascriptreact = true,
  vue = true,
  json = true,
  jsonc = true,
  json5 = true,
  markdown = true,
  html = true,
  css = true,
  yaml = true,
  toml = true,
}

local lsp_format_save = vim.api.nvim_create_augroup('lsp-format-on-save', {})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-format-attach', {}),
  callback = function(args)
    local ft = vim.bo[args.buf].filetype
    if conform_oxfmt_ft[ft] then
      return
    end
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client or not client:supports_method(vim.lsp.protocol.Methods.textDocument_formatting) then
      return
    end
    vim.api.nvim_clear_autocmds({ group = lsp_format_save, buffer = args.buf })
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = lsp_format_save,
      buffer = args.buf,
      callback = function()
        vim.lsp.buf.format({
          bufnr = args.buf,
          timeout_ms = 5000,
        })
      end,
    })
  end,
})

require('mason-lspconfig').setup({
  automatic_enable = {
    -- Prefer oxlint; uninstall Mason `eslint` if you no longer need it.
    exclude = { 'eslint' },
  },
})
