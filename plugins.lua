local packer = require 'packer'
local util = require 'packer.util'

packer.init({
  package_root = util.join_paths(vim.fn.stdpath('data'), 'site', 'pack')
})

return packer.startup(function(use)
  use {
    'f-person/auto-dark-mode.nvim',
    config = function()
      local auto_dark_mode = require('auto-dark-mode')
      auto_dark_mode.setup({
        update_interval = 1000,
        set_dark_mode = function()
          vim.api.nvim_set_option('background', 'dark')
          vim.cmd('colorscheme tokyonight-night')
        end,
        set_light_mode = function()
          vim.g.edge_style = "light"
          vim.g.edge_better_performance = 1
          vim.api.nvim_set_option('background', 'light')
          vim.cmd('colorscheme edge')
        end,
      })
      auto_dark_mode.init()
    end
  }
  use { "catppuccin/nvim", as = "catppuccin" }
  use 'sainnhe/edge'
  use 'marko-cerovac/material.nvim'
  use { 'davidbachmann/vim-punk-colorscheme' }
  use { 'yassinebridi/vim-purpura' }
  use { 'haishanh/night-owl.vim' }
  use { 'EdenEast/nightfox.nvim' }
  use { 'Rigellute/shades-of-purple.vim' }
  use { 'NLKNguyen/papercolor-theme' }
  use { 'neanias/everforest-nvim' }
  use { 'rainglow/vim' }
  use { 'projekt0n/github-nvim-theme', tag = 'v0.0.7' }
  use { 'wbthomason/packer.nvim' }
  use { 'bluz71/vim-nightfly-colors' }
  use { 'github/copilot.vim' }
  use { 'pineapplegiant/spaceduck' }
  use { 'kdheepak/lazygit.nvim' }
  use { "williamboman/mason-lspconfig.nvim" }
  use { "williamboman/mason.nvim" }
  use { "neovim/nvim-lspconfig" }
  use {
    "SmiteshP/nvim-navic",
    requires = "neovim/nvim-lspconfig",
    config = function ()
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
        "numToStr/Comment.nvim",        -- Optional
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
  -- use { 'hrsh7th/cmp-copilot' }
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
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons'

    },
  }
  use { 'folke/tokyonight.nvim' }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  use {
    'goolord/alpha-nvim',
    requires = { 'nvim-tree/nvim-web-devicons' },
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
    requires = "kyazdani42/nvim-web-devicons",
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
    "rcarriga/nvim-dap-ui",
    requires = { "mfussenegger/nvim-dap" },
    config = function()
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
    end
  }
  use {
    "vim-test/vim-test",
    config = function()
      vim.cmd('let g:test#php#runner = "sail"')
      vim.cmd('let test#php#phpunit#executable = "vendor/bin/sail test"')
      vim.cmd('let test#neovim#term_position = "vert"')
    end
  }
end)
