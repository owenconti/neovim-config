local vim = vim
local utils = require('owen.utils')

-- Misc keymaps
utils.mapkey('', '<leader>w', ':w!<CR>')
utils.mapkey('', '<leader>q', ':q!<CR>')
utils.mapkey('', '<leader>c', ':bd<CR>')
utils.mapkey('', '<leader>y', '"+y') -- copy to clipboard
utils.mapkey('', '<leader>R', ':w | :e<CR>')

-- Floaterm
utils.mapkey('', '<leader>t', ':FloatermNew --height=0.9 --width=0.8<CR>')
utils.mapkey('', '<Esc>', '<C-\\><C-n>:CFloatTerm<CR>')

-- No neck pain (centered buffers)
utils.mapkey('', '<leader>nn', ':NoNeckPain<CR>')

-- Search
utils.mapkey('', 'ZZ', ":let @/ = ''<CR>") -- clear search
-- utils.mapkey('', 'n', "nzz<CR>") -- center search result
-- utils.mapkey('', 'N', "Nzz<CR>") -- center search result

-- Splitting
utils.mapkey('', 'lsv', ':vsplit<CR>')
utils.mapkey('', 'lsh', ':hsplit<CR>')

-- Window management
utils.mapkey('', 'lw', '<C-w>')

-- Line management
utils.mapkey('', '<S-A-i>', ":m .-2<CR>==") -- move line up
utils.mapkey('', '<S-A-k>', ":m .+1<CR>==") -- move line down
utils.mapkey('v', '<S-A-i>', ":m '<-2<CR>gv=gv") -- move line up
utils.mapkey('v', '<S-A-k>', ":m '>+1<CR>gv=gv") -- move line down
utils.mapkey('', 'lzf', 'ViBzf'); -- Fold current position
utils.mapkey('', 'lf', 'Vj%y')
utils.mapkey('', 'lf', "Vj%y") -- Copy current function
utils.mapkey('', 'gs', '^') -- go to start of characters on line
utils.mapkey('', 'ge', '$') -- go to end of line
utils.mapkey('', '>', '>gv') -- reselect selection after indent
utils.mapkey('', '<', '<gv') -- reselect selection after indent
utils.mapkey('', 'ga', 'ggVG') -- select entire file

-- git
utils.mapkey('', 'gl', ':Gitsigns toggle_current_line_blame<CR>');
utils.mapkey('', '<leader>gg', ':LazyGit<CR>')


-- nvim-tree
utils.mapkey('', '<leader>e', ':NvimTreeFindFileToggle<CR>')
utils.mapkey('', '<leader>E', ':NvimTreeToggle<CR>')

-- trouble
utils.mapkey("", "gT", ":TroubleToggle<cr>")

-- test runner
utils.mapkey("", 'tf', ':TestNearest -strategy=basic<CR><C-\\>')
utils.mapkey("", 'tt', ':TestSuite<CR>')
utils.mapkey("", 'tr', ':TestLast<CR>')

-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fF', "<cmd>lua require('telescope.builtin').find_files({no_ignore = true})<CR>", {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
-- vim.keymap.set('n', '<leader>fr', builtin.resume, {})
vim.keymap.set('n', '<leader>fr', "<cmd>lua require('telescope.builtin').resume({cwd = vim.fn.expand('%:p:h')})<CR>")
vim.keymap.set('n', '<leader>fs', builtin.treesitter, {})
vim.keymap.set('n', '<leader>fp', builtin.pickers, {})
vim.keymap.set('n', '<leader>fo', "<cmd>lua require('telescope.builtin').oldfiles({only_cwd = true})<CR>")

-- movement
vim.keymap.set('n', 'gr', builtin.lsp_references, {})
vim.keymap.set('n', 'gd', builtin.lsp_definitions, {})
vim.keymap.set('n', 'gi', builtin.lsp_implementations, {})
vim.keymap.set('n', 'gbd', builtin.diagnostics, {})
vim.keymap.set('n', 'gf', vim.diagnostic.open_float, {})
vim.keymap.set('n', '<c-<space>>', vim.lsp.buf.signature_help, {})
vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})

-- diagnostics/formatting 
vim.keymap.set('n', '<space>ld', "<cmd>lua require('telescope.builtin').diagnostics({bufnr = 0})<CR>", {})
vim.keymap.set('n', '<leader>ls', "<cmd>lua require('telescope.builtin').lsp_document_symbols({cwd = vim.fn.expand('%:p:h')})<CR>")
vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, {})
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format, {})
vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, {})

-- git commands
utils.mapkey("", '<leader>gb', ':Git blame<CR>')
utils.mapkey("", '<leader>gd', ':Gdiff<CR>')

-- chatgpt commands
utils.mapkey("", '<leader>vo', ':ChatGPTRun optimize_code<CR>')
utils.mapkey("", '<leader>ve', ':ChatGPTEditWithInstructions<CR>')
utils.mapkey("", '<leader>vg', ':ChatGPTRun grammar_correction<CR>')

-- which key labels
local wk = require("which-key")
wk.add({
  { "<leader>E", desc = "Toggle explorer" },
  { "<leader>c", desc = "Close buffer" },
  { "<leader>e", desc = "Open explorer to current file" },

  { "<leader>v", group = "ChatGPT" },
  { "<leader>ve", desc = "Edit with instruction" },
  { "<leader>vo", desc = "Optimize code" },
  { "<leader>vg", desc = "Grammar correction" },

  { "<leader>f", group = "Files..." },
  { "<leader>fb", desc = "Find buffers" },
  { "<leader>ff", desc = "Find files" },
  { "<leader>fg", desc = "File search" },
  { "<leader>fh", desc = "Help tags" },
  { "<leader>fo", desc = "Recent files" },

  { "<leader>g", group = "Git" },
  { "<leader>gb", desc = "Git blame" },
  { "<leader>gg", desc = "Lazygit" },
  { "<leader>q", desc = "Quit nvim" },
  { "<leader>w", desc = "Write buffer" },
})
