local packer = require 'packer'
local util = require 'packer.util'

packer.init({
  package_root = util.join_paths(vim.fn.stdpath('data'), 'site', 'pack')
})

return packer.startup(function(use)
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
  use {
    "yetone/avante.nvim",
    branch = "main",
    config = function()
      require("avante").setup({
          hints = {
            enabled = false
          },
          windows = {
            width = 50
          },
          mappings = {
            ask = "<leader>aa",
            edit = "<leader>ae",
            refresh = "<leader>ar",
            --- @class AvanteConflictMappings
            diff = {
              ours = "<leader>ao",
              theirs = "<leader>at",
              none = "c0",
              both = "<leader>ab",
              next = "]x",
              prev = "[x",
            },
            jump = {
              next = "]]",
              prev = "[[",
            },
         },
      })
    end,
    requires = {
      "nvim-tree/nvim-web-devicons",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    }
  }
  -- Themes
  use 'Mofiqul/dracula.nvim'
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
  use {
    'nvim-tree/nvim-tree.lua',
    config = function()
      local HEIGHT_RATIO = 0.8
      local WIDTH_RATIO = 0.5

      require("nvim-tree").setup({
          git = {
            enable = true,
            ignore = false,
            timeout = 500,
          },
          view = {
            relativenumber = true,
            float = {
              enable = true,
              open_win_config = function()
                local screen_w = vim.opt.columns:get()
                local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
                local window_w = screen_w * WIDTH_RATIO
                local window_h = screen_h * HEIGHT_RATIO
                local window_w_int = math.floor(window_w)
                local window_h_int = math.floor(window_h)
                local center_x = (screen_w - window_w) / 2
                local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()

                return {
                  border = "rounded",
                  relative = "editor",
                  row = center_y,
                  col = center_x,
                  width = window_w_int,
                  height = window_h_int,
                }
              end,
            },
            width = function()
              return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
            end,
        }
      })
    end
  }
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
      vim.cmd('let test#php#phpunit#executable = "docker-compose -f docker-compose.custom.yml run --rm php-cli php artisan test"')
      vim.cmd('let test#neovim#term_position = "vert"')
    end
  }

  -- Set the colorscheme at the end to ensure it has been loaded
  -- vim.cmd('colorscheme dracula')
  -- vim.cmd('colorscheme github_light')
  -- vim.cmd('colorscheme kanagawa-wave')
  -- vim.cmd('colorscheme eldritch')
  vim.cmd('colorscheme rose-pine-main')

end)
