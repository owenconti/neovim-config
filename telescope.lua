require('telescope').setup({
  pickers = {
    find_files = {
      hidden = true,
      follow = true
    }
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "ignore_case"
    }
  },
  active = true,
  defaults = {
    vimgrep_arguments = { -- ripgrep bug https://github.com/nvim-telescope/telescope.nvim/issues/2482#issuecomment-1528053505
	    "rg",
	    "--color=never",
	    "--no-heading",
	    "--with-filename",
	    "--line-number",
	    "--column",
	    "--smart-case",
    },
    layout_strategy = "horizontal",
    theme = 'tokyonight-moon',
    path_display = {
      truncate = 3
    },
    layout_config = {
      horizontal = {
        height = 0.95,
        width = 0.95,
      },
    }
  },
})
require('telescope').load_extension('fzf')
require("telescope").load_extension("lazygit")
