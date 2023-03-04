require("nvim-tree").setup({
  git = {
    enable = false,
    ignore = false
  },
  view = {
    float = {
      enable = true,
      open_win_config = {
        width = 60
      }
    },
  },
})

local api = require("nvim-tree.api")
api.events.subscribe(api.events.Event.FileCreated, function(file)
  vim.cmd("edit " .. file.fname)
end)
