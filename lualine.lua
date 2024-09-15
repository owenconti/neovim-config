local navic = require("nvim-navic")

require("lualine").setup({
  options = {
    theme = 'auto'
  },
  winbar = {
    lualine_c = {
      {
        function()
          return navic.get_location()
        end,
      },
    }
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = {},
    lualine_x = {},
    lualine_y = {
      'branch',
      'diagnostics',
      'diff',
    },
    lualine_z = {},
  }
})
