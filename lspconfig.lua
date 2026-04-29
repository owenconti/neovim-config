local vim = vim

require('mason').setup()

local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.lsp.config('eslint', {
  capabilities = capabilities,
  on_init = function()
    vim.api.nvim_create_autocmd('BufWritePre', {
      pattern = { '*.tsx', '*.ts', '*.jsx', '*.js', '*.vue', '*.md', '*.cjs' },
      command = 'EslintFixAll',
      group = vim.api.nvim_create_augroup('eslint-lsp-formatting', {}),
    })
  end,
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

vim.lsp.config('intelephense', {
  capabilities = capabilities,
  init_options = {
    licenseKey = os.getenv('INTELEPHENSE_LICENSE_KEY'),
  },
})

-- lspconfig.phpactor.setup({
--   init_options = {
--     ["logging.enabled"] = true,
--     ["logging.level"] = "debug",
--     ["logging.path"] = "/tmp/phpactor.log",
--     ["completion_worse.completor.docblock.enabled"] = false,
--     ["language_server_completion.trim_leading_dollar"] = true,
--     ["language_server_php_cs_fixer.enabled"] = true
--   }
-- })

local lsp_format_save = vim.api.nvim_create_augroup('lsp-format-on-save', {})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-format-attach', {}),
  callback = function(args)
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

require('mason-lspconfig').setup()
