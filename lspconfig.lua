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

lspconfig.eslint.setup({})

lspconfig.ts_ls.setup({
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

lspconfig.tailwindcss.setup({
  settings = {
    tailwindCSS = {
      files = {
        exclude = { "node_modules", ".git", ".cache", "vendor", "public", "storage", "bootstrap" },
      }
    } 
  }
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

lspconfig.intelephense.setup({
  init_options = {
    licenseKey = os.getenv('INTELEPHENSE_LICENSE_KEY')
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

-- Increase timeout to allow phpcsfixer and eslint_d to format files without timing out
vim.lsp.buf.format({ timeout_ms = 5000 })
