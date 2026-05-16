local vim = vim

-- Neovim: `vim.highlight` is deprecated in favor of `vim.hl` (see :help vim.highlight).
-- Some plugins still read `vim.highlight` at load time; alias once before any plugin runs.
if vim.hl then
  vim.highlight = vim.hl
end

-- vim.filetype.add({
--  extension = {
--   templ = "templ",
--  },
-- })
vim.cmd([[ autocmd BufNewFile,BufRead *.templ setfiletype templ ]])

-- VIM OPTIONS
vim.g.mapleader = ' '

-- For nvim.tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Global scope
vim.o.whichwrap = "b,s,h,l"
-- vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
-- vim.o.statusline = "%{%v:lua.require'nvim-navic'.get_location()%}"
vim.o.timeoutlen = 500
vim.o.termguicolors = true
vim.o.syntax = 'on'
vim.o.errorbells = false
vim.o.smartcase = true
vim.o.smartindent = false
vim.o.showmode = false
vim.o.backup = false
vim.o.undodir = vim.fn.stdpath('config') .. '/undodir'
vim.o.undofile = true
vim.o.incsearch = true
vim.o.hidden = true
vim.o.completeopt = 'menuone,noinsert,noselect'
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.cursorline = true

-- Buffer scope
-- vim.bo.swapfgle = false
vim.bo.autoindent = true
vim.bo.smartindent = false
vim.bo.textwidth = 0

-- Window scope
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.signcolumn = 'yes'
vim.wo.wrap = true
vim.opt.smoothscroll = true

vim.opt.background = 'light'
vim.opt.foldmethod = 'indent'
vim.opt.foldlevel = 99

vim.opt.laststatus = 3
vim.opt.splitkeep = "screen"

-- Optional Vim hosts: disable so :checkhealth does not warn when these executables are absent.
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
