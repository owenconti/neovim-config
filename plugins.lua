return require('packer').startup(function(use)
  use { 'wbthomason/packer.nvim' }
  use { 'bluz71/vim-nightfly-colors' }
  use { 'github/copilot.vim' }
  use { 'pineapplegiant/spaceduck' }
  use { 'kdheepak/lazygit.nvim' }
  use { "williamboman/mason-lspconfig.nvim" }
  use { "williamboman/mason.nvim" }
  use { "neovim/nvim-lspconfig" }
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
  -- use { 'voldikss/vim-floaterm' }
  -- use { 'tpope/vim-fugitive' }
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
  use {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("indent_blankline").setup()
    end,
  }
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
    "SmiteshP/nvim-navic",
    requires = "neovim/nvim-lspconfig"
  }
  use {
    "vim-test/vim-test",
    config = function()
      vim.cmd('let g:test#php#runner = "phpunit"')
      vim.cmd('let test#php#phpunit#executable = "./vendor/bin/phpunit"')
      vim.cmd('let test#neovim#term_position = "vert"')
    end
  }
end)
