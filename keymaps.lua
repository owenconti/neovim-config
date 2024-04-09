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

-- github copilot
-- utils.mapkey('i', '<C-e>', '<cmd>copilot#Accept("")<CR>')
--

-- todo comments
utils.mapkey('', 'gt', "<cmd>TodoTelescope<cr>", "Todo list")

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
vim.keymap.set('n', 'gr', builtin.lsp_references, {})
vim.keymap.set('n', 'gd', builtin.lsp_definitions, {})
vim.keymap.set('n', 'gi', builtin.lsp_implementations, {})
vim.keymap.set('n', 'gbd', builtin.diagnostics, {})
vim.keymap.set('n', 'gf', vim.diagnostic.open_float, {})
vim.keymap.set('n', '<c-<space>>', vim.lsp.buf.signature_help, {})
vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
vim.keymap.set('n', '<space>ld', "<cmd>lua require('telescope.builtin').diagnostics({bufnr = 0})<CR>", {})
vim.keymap.set('n', '<leader>ls', "<cmd>lua require('telescope.builtin').lsp_document_symbols({cwd = vim.fn.expand('%:p:h')})<CR>")
vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, {})
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format, {})
vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, {})

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
  g = {
    name = "Git",
    g = "Lazygit",
    h = {
      name = "+Github",
      c = {
        name = "+Commits",
        c = { "<cmd>GHCloseCommit<cr>", "Close" },
        e = { "<cmd>GHExpandCommit<cr>", "Expand" },
        o = { "<cmd>GHOpenToCommit<cr>", "Open To" },
        p = { "<cmd>GHPopOutCommit<cr>", "Pop Out" },
        z = { "<cmd>GHCollapseCommit<cr>", "Collapse" },
      },
      i = {
        name = "+Issues",
        p = { "<cmd>GHPreviewIssue<cr>", "Preview" },
      },
      l = {
        name = "+Litee",
        t = { "<cmd>LTPanel<cr>", "Toggle Panel" },
      },
      r = {
        name = "+Review",
        b = { "<cmd>GHStartReview<cr>", "Begin" },
        c = { "<cmd>GHCloseReview<cr>", "Close" },
        d = { "<cmd>GHDeleteReview<cr>", "Delete" },
        e = { "<cmd>GHExpandReview<cr>", "Expand" },
        s = { "<cmd>GHSubmitReview<cr>", "Submit" },
        z = { "<cmd>GHCollapseReview<cr>", "Collapse" },
      },
      p = {
        name = "+Pull Request",
        c = { "<cmd>GHClosePR<cr>", "Close" },
        d = { "<cmd>GHPRDetails<cr>", "Details" },
        e = { "<cmd>GHExpandPR<cr>", "Expand" },
        o = { "<cmd>GHOpenPR<cr>", "Open" },
        p = { "<cmd>GHPopOutPR<cr>", "PopOut" },
        r = { "<cmd>GHRefreshPR<cr>", "Refresh" },
        t = { "<cmd>GHOpenToPR<cr>", "Open To" },
        z = { "<cmd>GHCollapsePR<cr>", "Collapse" },
      },
      t = {
        name = "+Threads",
        c = { "<cmd>GHCreateThread<cr>", "Create" },
        n = { "<cmd>GHNextThread<cr>", "Next" },
        t = { "<cmd>GHToggleThread<cr>", "Toggle" },
      },
    },
  }
}, { prefix = "<leader>" })
