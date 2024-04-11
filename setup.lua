local vim = vim

-- VIM OPTIONS
vim.g.mapleader = ' '

-- For nvim.tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Copilot
-- vim.g.copilot_no_tab_map = true
-- vim.g.copilot_assume_mapped = true
-- vim.g.copilot_tab_fallback = ""

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
vim.bo.swapfile = false
vim.bo.autoindent = true
vim.bo.smartindent = false
vim.bo.textwidth = 0

-- Window scope
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.signcolumn = 'yes'
vim.wo.wrap = true

vim.opt.background = 'dark'
vim.opt.foldmethod = 'indent'
vim.opt.foldlevel = 99

vim.cmd([[ colorscheme catppuccin-mocha ]])

-- Setup packer
-- local execute = vim.api.nvim_command
-- local fn = vim.fn
-- local install_path = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
-- if fn.empty(fn.glob(install_path)) > 0 then
--   execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
--   execute 'packadd packer.nvim'
-- end

-- vim.cmd('packadd packer.nvim')
--
-- local packer = require 'packer'
-- local util = require 'packer.util'
--
-- packer.init({
--   package_root = util.join_paths(vim.fn.stdpath('data'), 'site', 'pack')
-- })
