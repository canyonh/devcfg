return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    options = {
      theme = "tokyonight",
      globalstatus = true,
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch" },
      lualine_c = { { "filename", path = 2 } },
      lualine_x = { "diagnostics" },
      lualine_y = { "filetype" },
      lualine_z = { "location" },
    },
  },
}
