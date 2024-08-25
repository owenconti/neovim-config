local vim = vim
local lspconfig = require('lspconfig')

require('mason').setup()
require('mason-lspconfig').setup()

local on_attach = function(client, bufnr)
  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({
          bufnr = bufnr,
        })
      end,
    })
  end
end,


lspconfig.tsserver.setup({
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
  cmd = { "typescript-language-server", "--stdio" },
})

lspconfig.volar.setup({
  filetypes = { 'vue' },
  init_options = {
    vue = {
      hybridMode = false
    },
  }
})

lspconfig.tailwindcss.setup({})

lspconfig.eslint.setup({
  on_init = function(client)
    vim.api.nvim_create_autocmd('BufWritePre', {
      pattern = { '*.tsx', '*.ts', '*.jsx', '*.js', '*.vue', '*.md', '*.cjs' },
      command = 'EslintFixAll',
      group = vim.api.nvim_create_augroup('eslint-lsp-formatting', {}),
    })
  end,
  cmd = { "eslint_d", "--stdio" },
})

lspconfig.stylelint_lsp.setup{
  settings = {
    stylelintplus = {
      autoFixOnSave = true,
      autoFixOnFormat = true,
    }
  },
  filetypes = {"css"}
}

lspconfig.phpactor.setup({
  on_attach = on_attach,
  init_options = {
    ["completion_worse.completor.docblock.enabled"] = false,
    ["language_server_completion.trim_leading_dollar"] = true,
    ["language_server_php_cs_fixer.enabled"] = true
  }
})

-- Increase timeout to allow phpcsfixer and eslint_d to format files without timing out
vim.lsp.buf.format({ timeout_ms = 5000 })
