require("lualine").setup({
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "filename" },
    lualine_x = {},
    lualine_y = {
      'branch',
      'diagnostics',
      'diff',
    },
    lualine_z = {},
  }
})
