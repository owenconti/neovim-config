require("nvim-tree").setup({
  git = {
    enable = true,
    ignore = false,
    timeout = 500,
  },
  view = {
    relativenumber = true,
    side = "left",
    width = 35,
    preserve_window_proportions = true,
  },
  tab = {
    sync = { open = false, close = true },
  },
})

local api = require("nvim-tree.api")
api.events.subscribe(api.events.Event.FileCreated, function(file)
  vim.cmd("edit " .. file.fname)
end)

-- Persistent sidebar: open the tree on startup without stealing focus.
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function(data)
    local is_dir = vim.fn.isdirectory(data.file) == 1
    if is_dir then
      vim.cmd.cd(data.file)
      api.tree.open()
    else
      api.tree.toggle({ focus = false, find_file = true })
    end
  end,
})

-- Quit Neovim when the tree is the last window left.
vim.api.nvim_create_autocmd("QuitPre", {
  callback = function()
    local wins = vim.tbl_filter(function(w)
      return vim.api.nvim_win_get_config(w).relative == ""
    end, vim.api.nvim_list_wins())
    if #wins == 2 and api.tree.is_visible() then
      api.tree.close()
    end
  end,
})

-- Keep the sidebar in every normal tab, but never in Diffview tabs
-- (Diffview has its own file panel and breaks if windows change under it).
local function is_diffview_tab()
  for _, w in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local ft = vim.bo[vim.api.nvim_win_get_buf(w)].filetype
    if ft:match("^Diffview") then return true end
  end
  return false
end

vim.api.nvim_create_autocmd("TabEnter", {
  callback = function()
    vim.defer_fn(function()
      if is_diffview_tab() then
        if api.tree.is_visible() then api.tree.close_in_this_tab() end
      elseif not api.tree.is_visible() then
        api.tree.open({ focus = false })
      end
    end, 50)
  end,
})
