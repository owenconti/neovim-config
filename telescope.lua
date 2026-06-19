local search = require('owen.telescope-search')

require('telescope').setup({
  pickers = {
    find_files = {
      hidden = true,
      follow = true,
      entry_index = {
        ordinal = function(entry)
          local path = entry.value or entry[1]
          local filename = vim.fn.fnamemodify(path, ':t')

          return filename .. " " .. filename .. " " .. path
        end,
      },
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
      "--hidden",
      "--no-ignore",
      unpack(search.rg_exclude_globs()),
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

vim.api.nvim_create_autocmd("User", {
  pattern = "TelescopePreviewerLoaded",
  callback = function(args)
    if args.data.title ~= "Grep Preview" then
      return
    end

    local ok, action_state = pcall(require, "telescope.actions.state")
    if not ok then
      return
    end

    local query = action_state.get_current_line()
    if query == "" then
      return
    end

    pcall(vim.fn.matchdelete, vim.w.telescope_grep_match_id)
    vim.w.telescope_grep_match_id = vim.fn.matchadd("TelescopePreviewMatch", vim.fn.escape(query, [[\/.*$^~[]]))
  end,
})
