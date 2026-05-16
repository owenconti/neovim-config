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
  { 'projekt0n/github-nvim-theme' },

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

  {
    'carlos-algms/agentic.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'HakonHarnes/img-clip.nvim', opts = {} },
    },
    ---@type agentic.PartialUserConfig
    opts = {
      -- Built-ins include codex-acp, cursor-acp, claude-agent-acp, gemini-acp, opencode-acp, …
      provider = 'codex-acp',
    },
    keys = {
      {
        '<C-\\>',
        function()
          require('agentic').toggle()
        end,
        mode = { 'n', 'v', 'i' },
        desc = 'Toggle Agentic Chat',
      },
      {
        "<C-'>",
        function()
          require('agentic').add_selection_or_file_to_context()
        end,
        mode = { 'n', 'v' },
        desc = 'Add file or selection to Agentic context',
      },
      {
        '<C-,>',
        function()
          require('agentic').new_session()
        end,
        mode = { 'n', 'v', 'i' },
        desc = 'New Agentic Session',
      },
      {
        '<A-i>r',
        function()
          require('agentic').restore_session()
        end,
        mode = { 'n', 'v', 'i' },
        desc = 'Agentic restore session',
      },
      {
        '<leader>ad',
        function()
          require('agentic').add_current_line_diagnostics()
        end,
        mode = { 'n' },
        desc = 'Add current line diagnostics to Agentic',
      },
      {
        '<leader>aD',
        function()
          require('agentic').add_buffer_diagnostics()
        end,
        mode = { 'n' },
        desc = 'Add buffer diagnostics to Agentic',
      },
    },
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
          vim.opt.background = 'dark'
          vim.cmd.colorscheme('github_dark_default')
        end,
        set_light_mode = function()
          vim.opt.background = 'light'
          vim.cmd.colorscheme('github_light')
        end,
      })
    end,
  },
}
