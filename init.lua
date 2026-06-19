require('owen.setup')

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup(require('owen.lazy-plugins'), {
  -- Keep the lockfile inside the config repo (owen/ is symlinked to it) so
  -- pinned plugin versions are versioned and portable across machines.
  lockfile = vim.fn.stdpath('config') .. '/lua/owen/lazy-lock.json',
  defaults = {
    -- Match previous Packer `start` behavior so `require('owen.*')` below still works.
    lazy = false,
  },
  -- Use system `luarocks` (e.g. Homebrew); avoid lazy-rocks/hererocks when possible.
  rocks = {
    enabled = true,
    hererocks = false,
  },
})

require('owen.cmp-nvim-lsp')
require('owen.git')
require('owen.lspconfig')
require('owen.php-on-save')
require('owen.lualine')
require('owen.nvim-tree')
require('owen.telescope')
-- treesitter: configured from lazy.nvim `config` on nvim-treesitter (see lazy-plugins.lua)
require('owen.keymaps')
