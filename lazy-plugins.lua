-- Plugin specs for lazy.nvim (see init.lua bootstrap).

return {
  { 'rose-pine/neovim', name = 'rose-pine', branch = 'main' },

  {
    'stevearc/conform.nvim',
    config = function()
      require('conform').setup({
        formatters_by_ft = {
          php = { 'php_cs_fixer' },
        },
        format_after_save = {
          timeout_ms = 1000,
        },
      })
    end,
  },

  {
    'nvimdev/dashboard-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('dashboard').setup({
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
            enable = false,
          },
          packages = { enable = false },
          project = { enable = false },
          footer = {},
        },
      })
    end,
  },

  { 'sheerun/vim-polyglot' },

  {
    'shortcuts/no-neck-pain.nvim',
    version = '*',
    config = function()
      require('no-neck-pain').setup({
        width = 80,
        buffers = {
          right = {
            enabled = false,
          },
          scratchPad = {
            enabled = true,
            pathToFile = 'nvim-scratchpad.md',
          },
          bo = {
            filetype = 'md',
          },
        },
      })
    end,
  },

  { 'tpope/vim-fugitive' },
  { 'sainnhe/edge' },
  { 'kdheepak/lazygit.nvim' },

  { 'mason-org/mason.nvim' },
  { 'mason-org/mason-lspconfig.nvim' },
  { 'neovim/nvim-lspconfig' },

  {
    'SmiteshP/nvim-navic',
    dependencies = { 'neovim/nvim-lspconfig' },
    config = function()
      require('nvim-navic').setup({
        highlight = true,
        safe_output = true,
        lsp = {
          auto_attach = false,
        },
      })
    end,
  },

  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-buffer' },
  { 'nvim-lua/plenary.nvim' },
  {
    -- `main` is a full rewrite (no `nvim-treesitter.configs`); `master` stays compatible with Nvim 0.11 + your setup.
    'nvim-treesitter/nvim-treesitter',
    branch = 'master',
    build = ':TSUpdate',
    config = function()
      require('owen.treesitter')
    end,
  },
  { 'hrsh7th/nvim-cmp' },
  { 'voldikss/vim-floaterm' },
  { 'ldelossa/litee.nvim' },

  {
    'akinsho/git-conflict.nvim',
    version = '*',
    config = function()
      require('git-conflict').setup()
    end,
  },

  { 'lewis6991/gitsigns.nvim' },

  {
    'kylechui/nvim-surround',
    version = '*',
    config = function()
      require('nvim-surround').setup({})
    end,
  },

  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'kdheepak/lazygit.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
      },
    },
  },
  { 'nvim-tree/nvim-tree.lua' },
  { 'nvim-lualine/lualine.nvim' },
  { 'folke/which-key.nvim' },

  {
    'folke/trouble.nvim',
    config = function()
      require('trouble').setup({
        mode = 'document_diagnostics',
      })
    end,
  },

  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup({})
    end,
  },

  {
    'windwp/nvim-ts-autotag',
    config = function()
      require('nvim-ts-autotag').setup()
    end,
  },

  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup({})
    end,
  },

  { 'editorconfig/editorconfig-vim' },

  {
    'phaazon/hop.nvim',
    branch = 'v2',
    event = 'BufRead',
    config = function()
      require('hop').setup()
      vim.keymap.set('n', 's', ':HopChar2<CR>', { silent = true })
      vim.keymap.set('n', 'S', ':HopWord<CR>', { silent = true })
    end,
  },

  {
    'vim-test/vim-test',
    config = function()
      vim.cmd([[
        let g:test#php#runner = "phpunit"
        let test#php#pest#executable = "docker-compose -f docker-compose.custom.yml run --rm php-cli php artisan test"
        let test#php#phpunit#executable = "docker-compose -f docker-compose.custom.yml run --rm php-cli php artisan test"
        let test#neovim#term_position = "vert"
      ]])
    end,
  },

  {
    'f-person/auto-dark-mode.nvim',
    branch = 'main',
    config = function()
      require('auto-dark-mode').setup({
        update_interval = 1000,
        set_dark_mode = function()
          vim.cmd.colorscheme('rose-pine-main')
        end,
        set_light_mode = function()
          vim.cmd.colorscheme('edge')
        end,
      })
    end,
  },
}
