local packer = require 'packer'
local util = require 'packer.util'

packer.init({
  package_root = util.join_paths(vim.fn.stdpath('data'), 'site', 'pack')
})

return packer.startup(function(use)
  use {'psliwka/vim-smoothie'}
  use({
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          php = {'php_cs_fixer'}
        },
        format_after_save = {
          timeout_ms = 1000,
        },
      })
    end,
  })
  use {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('dashboard').setup {
        theme = 'hyper',
        config = {
          shortcut = {},
          header = {
            '      ___           ___           ___           ___                       ___     ',
            '     /\\__\\         /\\  \\         /\\  \\         /\\__\\          ___        /\\__\\    ',
            '    /::|  |       /::\\  \\       /::\\  \\       /:/  /         /\\  \\      /::|  |   ',
            '   /:|:|  |      /:/\\:\\  \\     /:/\\:\\  \\     /:/  /          \\:\\  \\    /:|:|  |   ',
            '  /:/|:|  |__   /::\\~\\:\\  \\   /:/  \\:\\  \\   /:/__/  ___      /::\\__\\  /:/|:|__|__ ',
            ' /:/ |:| /\\__\\ /:/\\:\\ \\:\\__\\ /:/__/ \\:\\__\\  |:|  | /\\__\\  __/:/\\/__/ /:/ |::::\\__\\',
            ' \\/__|:|/:/  / \\:\\~\\:\\ \\/__/ \\:\\  \\ /:/  /  |:|  |/:/  / /\\/:/  /    \\/__/~~/:/  /',
            '     |:/:/  /   \\:\\ \\:\\__\\    \\:\\  /:/  /   |:|__/:/  /  \\::/__/           /:/  / ',
            '     |::/  /     \\:\\ \\/__/     \\:\\/:/  /     \\::::/__/    \\:\\__\\          /:/  /  ',
            '     /:/  /       \\:\\__\\        \\::/  /       ~~~~         \\/__/         /:/  /   ',
            '     \\/__/         \\/__/         \\/__/                                   \\/__/    ',
          },
          week_header = {
            enable = false
          },
          packages = { enable = false },
          project = { enable = false },
          footer = {},
        }
      }
    end,
    requires = {'nvim-tree/nvim-web-devicons'}
  }
  -- Themes
  -- use 'Mofiqul/dracula.nvim'
  -- use 'projekt0n/github-nvim-theme'
  -- use "rebelot/kanagawa.nvim"
  -- use "eldritch-theme/eldritch.nvim"
  use "rose-pine/neovim"


  -- Plugins
  use { "sheerun/vim-polyglot" }
  use {
    "shortcuts/no-neck-pain.nvim",
    tag = "*",
    config = function()
        require("no-neck-pain").setup({
          width = 80,
          buffers = {
            right = {
              enabled = false,
            },
            scratchPad = {
              enabled = true,
              pathToFile = "nvim-scratchpad.md", 
            },
            bo = {
                filetype = "md"
            },
          },
      })
    end
  }
  use({
    "jackMort/ChatGPT.nvim",
    config = function()
      require("chatgpt").setup()
    end,
    requires = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim",
      "nvim-telescope/telescope.nvim"
    }
  })
  use 'tpope/vim-fugitive'
  use { 'sainnhe/edge' }
  use { 'wbthomason/packer.nvim' }
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
  use { 'hrsh7th/cmp-nvim-lsp' }
  use { 'hrsh7th/cmp-buffer' }
  use { 'nvim-lua/plenary.nvim' }
  use { 'nvim-treesitter/nvim-treesitter' }
  use { 'hrsh7th/nvim-cmp' }
  use 'voldikss/vim-floaterm'
  use { 'ldelossa/litee.nvim' }
  use {
    'akinsho/git-conflict.nvim',
    tag = "*",
    config = function()
      require('git-conflict').setup()
    end
  }
  use {'lewis6991/gitsigns.nvim'}
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
    'nvim-telescope/telescope.nvim',
    requires = { { 'nvim-lua/plenary.nvim' }, { "kdheepak/lazygit.nvim" } },
  }
  use {'nvim-tree/nvim-tree.lua'}
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use {'nvim-lualine/lualine.nvim'}
  use {"folke/which-key.nvim"}
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
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end
  }
  use {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup {}
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
  use {
    "vim-test/vim-test",
    config = function()
      vim.cmd('let g:test#php#runner = "phpunit"')
      vim.cmd('let test#php#pest#executable = "docker-compose -f docker-compose.custom.yml run --rm php-cli php artisan test"')
      vim.cmd('let test#php#phpunit#executable = "docker-compose -f docker-compose.custom.yml run --rm php-cli php artisan test"')
      vim.cmd('let test#neovim#term_position = "vert"')
    end
  }

  use {
    "f-person/auto-dark-mode.nvim",
    config = function()
      require('auto-dark-mode').setup({
        update_interval = 1000,
        set_dark_mode = function()
          vim.cmd('colorscheme rose-pine-main')
        end,
        set_light_mode = function()
          vim.cmd('colorscheme edge')
        end
      })
    end
  }

  -- Set the colorscheme at the end to ensure it has been loaded
  -- vim.cmd('colorscheme dracula')
  -- vim.cmd('colorscheme github_light')
  -- vim.cmd('colorscheme kanagawa-wave')
  -- vim.cmd('colorscheme eldritch')
  vim.cmd('colorscheme rose-pine-main')

end)
