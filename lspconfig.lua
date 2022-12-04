local vim = vim

require('mason').setup()
require('mason-lspconfig').setup()

-- Start specific LSP configuration
require('lspconfig').tailwindcss.setup({})

require('lspconfig').volar.setup({
  filetypes = { 'vue' }
})

require('lspconfig').eslint.setup({
  on_init = function(client)
    vim.api.nvim_create_autocmd('BufWritePre', {
      pattern = { '*.tsx', '*.ts', '*.jsx', '*.js', '*.vue' },
      command = 'EslintFixAll',
      group = vim.api.nvim_create_augroup('eslint-lsp-formatting', {}),
    })
  end,
})

require('lspconfig').psalm.setup({})

require('lspconfig').phpactor.setup({})
vim.cmd([[
    augroup LspPhpactor
      autocmd!
      autocmd Filetype php command! -nargs=0 LspPhpactorReindex lua vim.lsp.buf_notify(0, "phpactor/indexer/reindex",{})
    augroup END
]])

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
  -- on_attach = function(client, bufnr)
  --   if client.supports_method("textDocument/formatting") then
  --     vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
  --     vim.api.nvim_create_autocmd("BufWritePre", {
  --       group = augroup,
  --       buffer = bufnr,
  --       callback = function()
  --         vim.lsp.buf.format({
  --           filter = function(client)
  --             -- apply whatever logic you want (in this example, we'll only use null-ls)
  --             return client.name == "null-ls"
  --           end,
  --           bufnr = bufnr,
  --         })
  --       end,
  --     })
  --   end
  -- end,
})
