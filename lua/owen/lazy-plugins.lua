-- Plugin specs for lazy.nvim (see init.lua bootstrap).

local treesitter_languages = {
  'bash',
  'c',
  'css',
  'html',
  'javascript',
  'json',
  'jsonc',
  'lua',
  'markdown',
  'markdown_inline',
  'php',
  'python',
  'query',
  'toml',
  'tsx',
  'typescript',
  'vim',
  'vimdoc',
  'vue',
  'yaml',
}

return {
  { 'rose-pine/neovim', name = 'rose-pine', branch = 'main' },
  {
    'projekt0n/github-nvim-theme',
    lazy = false,
    priority = 1000,
    config = function()
      -- Neovim auto-detects the terminal's background via an OSC 11 query at
      -- startup (works over SSH/tmux, unlike OS-API dark-mode detection) and
      -- blocks on the handshake before running user config, so &background is
      -- already correct here for in-order terminals like Ghostty.
      local function want()
        return vim.o.background == 'dark' and 'github_dark_default' or 'github_light'
      end
      vim.cmd.colorscheme(want())
      -- Fallback for terminals that answer the bg query out of order: Neovim
      -- updates &background when the late OSC 11 reply arrives and fires
      -- TermResponse (OptionSet does NOT fire for 'background'). Re-apply only
      -- when the colorscheme no longer matches the detected background.
      vim.api.nvim_create_autocmd('TermResponse', {
        callback = function()
          if vim.g.colors_name ~= want() then
            vim.schedule(function() vim.cmd.colorscheme(want()) end)
          end
        end,
      })
    end,
  },

  {
    'stevearc/conform.nvim',
    config = function()
      require('conform').setup({
        formatters_by_ft = {
          javascript = { 'oxfmt' },
          javascriptreact = { 'oxfmt' },
          typescript = { 'oxfmt' },
          typescriptreact = { 'oxfmt' },
          vue = { 'oxfmt' },
          json = { 'oxfmt' },
          jsonc = { 'oxfmt' },
          json5 = { 'oxfmt' },
          markdown = { 'oxfmt' },
          html = { 'oxfmt' },
          css = { 'oxfmt' },
          yaml = { 'oxfmt' },
          toml = { 'oxfmt' },
        },
        -- Align with Diagonal: `source.fixAll.oxc` then `source.format.oxc` (oxfmt). PHP uses `.vscode/run-on-save`, not conform.
        format_on_save = function(bufnr)
          local ft = vim.bo[bufnr].filetype
          if ft == 'php' then
            return nil
          end
          local oxc = {
            typescript = true,
            typescriptreact = true,
            javascript = true,
            javascriptreact = true,
            vue = true,
            json = true,
            jsonc = true,
            json5 = true,
            markdown = true,
            html = true,
            css = true,
            yaml = true,
            toml = true,
          }
          if not oxc[ft] then
            return nil
          end
          pcall(function()
            vim.api.nvim_buf_call(bufnr, function()
              vim.cmd('silent! LspOxlintFixAll')
            end)
          end)
          return { timeout_ms = 5000, lsp_format = 'never' }
        end,
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
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    dependencies = { 'neovim-treesitter/treesitter-parser-registry' },
    build = function()
      require('nvim-treesitter').install(treesitter_languages):wait(300000)
    end,
    config = function()
      require('owen.treesitter')
    end,
  },
  { 'hrsh7th/nvim-cmp' },
  {
    'sindrets/diffview.nvim',
    config = function()
      local actions = require('diffview.actions')
      -- <leader>e: focus the file list, or hide it when already in it
      -- (matches the nvim-tree mapping). Replaces Diffview's own <leader>e/<leader>b.
      local function files_toggle()
        if vim.bo.filetype == 'DiffviewFiles' or vim.bo.filetype == 'DiffviewFileHistory' then
          actions.toggle_files()
        else
          actions.focus_files()
        end
      end
      local map = { { 'n', '<leader>e', files_toggle, { desc = 'Focus/hide file list' } } }
      require('diffview').setup({
        keymaps = { view = map, file_panel = map, file_history_panel = map },
      })
    end,
  },
  {
    'milanglacier/minuet-ai.nvim',
    config = function()
      require('owen.minuet')
    end,
  },
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
    'vim-test/vim-test',
    config = function()
      vim.cmd([[
        let g:test#php#runner = "phpunit"
        let test#php#pest#executable = "docker compose run --rm php-cli php artisan test"
        let test#php#phpunit#executable = "docker compose run --rm php-cli php artisan test"
        let test#neovim#term_position = "vert"

        function! TestRemoveColorsTransform(cmd) abort
          return substitute(a:cmd, ' --colors', '', 'g')
        endfunction

        let g:test#custom_transformations = get(g:, 'test#custom_transformations', {})
        let g:test#custom_transformations['remove_colors'] = function('TestRemoveColorsTransform')
        let g:test#transformation = 'remove_colors'
      ]])
    end,
  },
}
