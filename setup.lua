local vim = vim

-- VIM OPTIONS
vim.g.mapleader = ' '
vim.cmd [[colorscheme tokyonight-moon]]

-- For nvim.tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Global scope
vim.o.timeoutlen = 500
vim.o.termguicolors = true
vim.o.syntax = 'on'
vim.o.errorbells = false
vim.o.smartcase = true
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

-- Buffer scope
vim.bo.swapfile = false
vim.bo.autoindent = true
vim.bo.smartindent = true

-- Window scope
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.signcolumn = 'yes'
vim.wo.wrap = false

-- Setup packer
-- local execute = vim.api.nvim_command
-- local fn = vim.fn
-- local install_path = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
-- if fn.empty(fn.glob(install_path)) > 0 then
--   execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
--   execute 'packadd packer.nvim'
-- end

vim.cmd('packadd packer.nvim')

local packer = require 'packer'
local util = require 'packer.util'

packer.init({
  package_root = util.join_paths(vim.fn.stdpath('data'), 'site', 'pack')
})
