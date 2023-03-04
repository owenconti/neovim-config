local vim = vim
local utils = require('owen.utils')

-- Misc keymaps
utils.mapkey('', '<leader>w', ':w!<CR>')
utils.mapkey('', '<leader>q', ':q!<CR>')
utils.mapkey('', '<leader>c', ':bd<CR>')
utils.mapkey('', '<leader>y', '"+y') -- copy to clipboard
utils.mapkey('', '<leader>R', ':w | :e<CR>')

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
utils.mapkey('', '<A-i>', ":m .-2<CR>==") -- move line up
utils.mapkey('', '<A-k>', ":m .+1<CR>==") -- move line down
utils.mapkey('v', '<A-i>', ":m '<-2<CR>gv=gv") -- move line up
utils.mapkey('v', '<A-k>', ":m '>+1<CR>gv=gv") -- move line down
utils.mapkey('', 'lzf', 'ViBzf'); -- Fold current position
utils.mapkey('', 'lf', 'Vj%y')
utils.mapkey('', 'lf', "Vj%y") -- Copy current function
utils.mapkey('', 'gs', '^') -- go to start of characters on line
utils.mapkey('', 'ge', '$') -- go to end of line
utils.mapkey('', '>', '>gv') -- reselect selection after indent
utils.mapkey('', '<', '<gv') -- reselect selection after indent
utils.mapkey('', 'ga', 'ggVG') -- select entire file

-- git
utils.mapkey('', 'gl', ':ToggleBlameLine<CR>');
utils.mapkey('', '<leader>gg', ':LazyGit<CR>')
utils.mapkey('', '<leader>gh', ':vert G log --oneline<CR>')

-- github copilot
-- utils.mapkey('i', '<C-e>', '<cmd>copilot#Accept("")<CR>')

-- todo comments
utils.mapkey('', 'gt', "<cmd>TodoTelescope<cr>", "Todo list")

-- nvim-tree
utils.mapkey('', '<leader>e', ':NvimTreeFindFile<CR>')
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
vim.keymap.set('n', '<leader>fr', builtin.resume, {})
vim.keymap.set('n', '<leader>fs', builtin.treesitter, {})
vim.keymap.set('n', '<leader>fp', builtin.pickers, {})
vim.keymap.set('n', '<leader>fo', "<cmd>lua require('telescope.builtin').oldfiles({only_cwd = true})<CR>")
vim.keymap.set('n', 'gr', builtin.lsp_references, {})
vim.keymap.set('n', 'gd', builtin.lsp_definitions, {})
vim.keymap.set('n', 'gi', builtin.lsp_implementations, {})
vim.keymap.set('n', 'gbd', builtin.diagnostics, {})
vim.keymap.set('n', '<c-<space>>', vim.lsp.buf.signature_help, {})
vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
vim.keymap.set('n', '<space>ld', "<cmd>lua require('telescope.builtin').diagnostics({bufnr = 0})<CR>", {})
vim.keymap.set('n', '<leader>ls', "<cmd>lua require('telescope.builtin').lsp_document_symbols({cwd = vim.fn.expand('%:p:h')})<CR>")
vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, {})
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format, {})
vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, {})

-- debugger
local dap = require('dap')
dap.adapters.php = {
  type = 'executable',
  command = 'node',
  args = { '/Users/owen/development/vscode-php-debug/out/phpDebug.js' }
}

dap.configurations.php = {
  {
    type = 'php',
    request = 'launch',
    name = 'Listen for Xdebug',
    port = 9003
  }
}


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
  d = {
    name = "Debug",
    t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
    b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
    c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
    C = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor" },
    d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
    g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
    i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
    o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
    u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
    p = { "<cmd>lua require'dap'.pause()<cr>", "Pause" },
    r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
    s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
    q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
    U = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle UI" },
  },
}, { prefix = "<leader>" })
