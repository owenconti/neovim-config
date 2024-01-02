local vim = vim

require('mason').setup()
require('mason-lspconfig').setup()

require('lspconfig').tsserver.setup({
  on_attach = on_attach,
  filetypes = { "typescriptreact", "typescript.tsx" },
  cmd = { "typescript-language-server", "--stdio" }
})

require('lspconfig').volar.setup({
  on_attach = on_attach,
  filetypes = { 'vue', 'typescript' }
})

-- Start specific LSP configuration
require('lspconfig').tailwindcss.setup({})

local on_attach = function(client, bufnr)
  -- if client.server_capabilities.documentSymbolProvider then
  --   navbuddy.attach(client, bufnr)
    -- navic.attach(client, bufnr)
  -- end

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

require('lspconfig').eslint.setup({
  on_attach = on_attach,
  on_init = function(client)
    vim.api.nvim_create_autocmd('BufWritePre', {
      pattern = { '*.tsx', '*.ts', '*.jsx', '*.js', '*.vue', '*.md', '*.cjs' },
      command = 'EslintFixAll',
      group = vim.api.nvim_create_augroup('eslint-lsp-formatting', {}),
    })
  end,
})

require'lspconfig'.stylelint_lsp.setup{
  settings = {
    stylelintplus = {
      autoFixOnSave = true,
      autoFixOnFormat = true,
    }
  },
  filetypes = {"css"}
}

-- require('lspconfig').psalm.setup({})
--
require('lspconfig').phpactor.setup({
  on_attach = on_attach,
  init_options = {
    ["completion_worse.completor.docblock.enabled"] = false,
    ["language_server_completion.trim_leading_dollar"] = true,
    ["language_server_php_cs_fixer.enabled"] = true
  }
})

-- End specific LSP configuration

-- Increase timeout to allow phpcsfixer and eslint_d to format files without timing out
vim.lsp.buf.format({ timeout_ms = 5000 })

-- local null_ls = require("null-ls")
-- null_ls.setup({
--   sources = {
--     -- code actions
--     -- null_ls.builtins.code_actions.eslint_d,
--     -- diagnostics
--     -- null_ls.builtins.diagnostics.eslint_d,
--     -- formatting
--     null_ls.builtins.formatting.phpcsfixer,
--     -- null_ls.builtins.formatting.eslint_d,
--   },
--   on_attach = function(client, bufnr)
--     if client.supports_method("textDocument/formatting") then
--       vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
--       vim.api.nvim_create_autocmd("BufWritePre", {
--         group = augroup,
--         buffer = bufnr,
--         callback = function()
--           vim.lsp.buf.format({
--             bufnr = bufnr,
--           })
--         end,
--       })
--     end
--   end,
-- })
