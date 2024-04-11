local packer = require 'packer'
local util = require 'packer.util'

packer.init({
  package_root = util.join_paths(vim.fn.stdpath('data'), 'site', 'pack')
})

return packer.startup(function(use)
  use 'tpope/vim-fugitive'
  use { 'sainnhe/edge' }
  use {
    "catppuccin/nvim",
    as = "catppuccin",
    config = function()
      require('catppuccin').setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        term_colors = true,
        transparent_background = true
      })
      vim.cmd('set background=dark')
    end
  }
  use { 'rainglow/vim' }
  use { 'wbthomason/packer.nvim' }
  use { 'github/copilot.vim' }
  use { 'kdheepak/lazygit.nvim' }
  use { "williamboman/mason-lspconfig.nvim" }
  use { "williamboman/mason.nvim" }
  use { "neovim/nvim-lspconfig" }
  use {
    "SmiteshP/nvim-navic",
    requires = "neovim/nvim-lspconfig",
    config = function()
      local navic = require("nvim-navic")
      navic.setup({
        highlight = true,
        safe_output = true,
        lsp = {
          auto_attach = false
        }
      })
    end
  }
  use {
    "SmiteshP/nvim-navbuddy",
    requires = {
      "neovim/nvim-lspconfig",
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
      "numToStr/Comment.nvim", -- Optional
      "nvim-telescope/telescope.nvim" -- Optional
    },
    config = function()
      require('nvim-navbuddy').setup({
        highlight = true,
        safe_output = true,
        lsp = {
          auto_attach = true,
          preference = { "tsserver", "phpactor" }
        }
      })
    end
  }
  use { 'hrsh7th/cmp-nvim-lsp' }
  use { 'hrsh7th/cmp-buffer' }
  use { 'nvim-lua/plenary.nvim' }
  use { "jose-elias-alvarez/null-ls.nvim" }
  use { 'nvim-treesitter/nvim-treesitter' }
  use { 'sheerun/vim-polyglot' }
  use { 'l3mon4d3/luasnip' }
  use { 'hrsh7th/nvim-cmp' }
  use { 'saadparwaiz1/cmp_luasnip' }
  use { 'rafamadriz/friendly-snippets' }
  use 'voldikss/vim-floaterm'
  use { 'ldelossa/litee.nvim' }
  use {
    'akinsho/git-conflict.nvim',
    tag = "*",
    config = function()
      require('git-conflict').setup()
    end
  }
  use {
    'lewis6991/gitsigns.nvim',
  }
  use({
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  })
  use "lukas-reineke/indent-blankline.nvim"
  use {
    'nvim-telescope/telescope.nvim',
    requires = { { 'nvim-lua/plenary.nvim' }, { "kdheepak/lazygit.nvim" } },
    config = function()
      require("telescope").load_extension("lazygit")
    end
  }
  use {
    'nvim-tree/nvim-tree.lua'
  }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use {
    'nvim-lualine/lualine.nvim'
  }
  use {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }
  use {
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup {
        mode = 'document_diagnostics'
      }
    end
  }
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup({})
    end
  }
  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }
  use {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end
  }
  use {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({})
    end
  }
  use { 'editorconfig/editorconfig-vim' }
  use {
    "phaazon/hop.nvim",
    event = "bufread",
    branch = 'v2', -- optional but strongly recommended
    config = function()
      require("hop").setup()
      vim.api.nvim_set_keymap("n", "s", ":HopChar2<cr>", { silent = true })
      vim.api.nvim_set_keymap("n", "S", ":HopWord<cr>", { silent = true })
    end
  }
  use { "tveskag/nvim-blame-line" }
  use {
    "vim-test/vim-test",
    config = function()
      vim.cmd('let g:test#php#runner = "sail"')
      vim.cmd('let test#php#phpunit#executable = "vendor/bin/sail test"')
      vim.cmd('let test#neovim#term_position = "vert"')
    end
  }
end)
