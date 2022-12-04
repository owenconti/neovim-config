local vim = vim
local utils = require('owen.utils')

-- Misc keymaps
utils.mapkey('', '<leader>w', ':w!<CR>')
utils.mapkey('', '<leader>q', ':q!<CR>')
utils.mapkey('', '<leader>c', ':bd<CR>')

-- Search
utils.mapkey('', 'zz', ":let @/ = ''<CR>") -- clear search

-- Splitting
utils.mapkey('', 'lsv', ':vsplit<CR>')
utils.mapkey('', 'lsh', ':hsplit<CR>')

-- Window management
-- vim.cmd("nnoremap lw <C-w>")
utils.mapkey('', 'lw', '<C-w>')

-- Line management
utils.mapkey('', '<leader>/', "gcc") -- move line up
utils.mapkey('', '<A-i>', ":m .-2<CR>==") -- move line up
utils.mapkey('', '<A-k>', ":m .+1<CR>==") -- move line down
utils.mapkey('v', '<A-i>', ":m '<-2<CR>gv=gv") -- move line up
utils.mapkey('v', '<A-k>', ":m '>+1<CR>gv=gv") -- move line down
utils.mapkey('', 'lzf', 'ViBzf'); -- Fold current position
utils.mapkey('', 'lf', 'Vj%y')
utils.mapkey('', 'lf', "Vj%y") -- Copy current function
utils.mapkey('', 'gs', '^') -- go to start of characters on line
utils.mapkey('', 'ge', '$') -- go to end of line

-- todo comments
utils.mapkey('', 'gt', "<cmd>TodoTelescope<cr>", "Todo list")

-- nvim-tree
utils.mapkey('', '<leader>e', ':NvimTreeFindFile<CR>')
utils.mapkey('', '<leader>E', ':NvimTreeToggle<CR>')

-- trouble
utils.mapkey("", "gT", ":TroubleToggle<cr>")

-- test runner
utils.mapkey("", 'tf', ':TestNearest<CR><C-\\>')
utils.mapkey("", 'tt', ':TestSuite<CR>')
utils.mapkey("", 'tr', ':TestLast<CR>')

-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fo', "<cmd>lua require('telescope.builtin').oldfiles({cwd = vim.fn.expand('%:p:h')})<CR>")
vim.keymap.set('n', 'gr', builtin.lsp_references, {})
vim.keymap.set('n', 'gd', builtin.lsp_definitions, {})
vim.keymap.set('n', 'gbd', builtin.diagnostics, {})
vim.keymap.set('n', '<c-<space>>', vim.lsp.buf.signature_help, {})

-- which key labels
local wk = require("which-key")
wk.register({
  c = "Close buffer",
  q = "Quit nvim",
  w = "Write buffer",
  e = "Open explorer to current file",
  E = "Toggle explorer",
  f = {
    name = "Files...",
    f = 'Find files',
    g = 'File search',
    b = 'Find buffers',
    h = 'Help tags',
    o = 'Recent files'
  },
}, { prefix = "<leader>" })
