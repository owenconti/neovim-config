local vim = vim

require('mason').setup()
require('mason-lspconfig').setup()

-- Start specific LSP configuration
require('lspconfig').tailwindcss.setup({})

require('lspconfig').tsserver.setup({
  on_attach = on_attach,
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
  cmd = { "typescript-language-server", "--stdio" }
})

require('lspconfig').volar.setup({
  filetypes = { 'vue' }
})

local navic = require("nvim-navic")
navic.setup({
  highlight = true
})

local on_attach = function(client, bufnr)
  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end
end

require('lspconfig').eslint.setup({
  on_attach = on_attach,
  on_init = function(client)
    vim.api.nvim_create_autocmd('BufWritePre', {
      pattern = { '*.tsx', '*.ts', '*.jsx', '*.js', '*.vue', '*.md' },
      command = 'EslintFixAll',
      group = vim.api.nvim_create_augroup('eslint-lsp-formatting', {}),
    })
  end,
})

-- require('lspconfig').psalm.setup({})
--
require('lspconfig').phpactor.setup({
  on_attach = on_attach
})

-- require('lspconfig').intelephense.setup({
--   on_attach = on_attach,
--   settings = {
--     intelephense = {
--       files = {
--         maxSize = 100000;
--       };
--       diagnostics = {
--         undefinedFunctions = true;
--         undefinedMethods = true;
--         undefinedTypes = false;
--       }
--     };
--   },
-- })

-- End specific LSP configuration

-- Increase timeout to allow phpcsfixer and eslint_d to format files without timing out
vim.lsp.buf.format({ timeout_ms = 5000 })

local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    -- code actions
    -- null_ls.builtins.code_actions.eslint_d,
    -- diagnostics
    -- null_ls.builtins.diagnostics.eslint_d,
    -- formatting
    null_ls.builtins.formatting.phpcsfixer,
    -- null_ls.builtins.formatting.eslint_d,
  },
  on_attach = function(client, bufnr)
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
})
