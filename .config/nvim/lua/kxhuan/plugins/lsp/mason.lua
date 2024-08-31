return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")

    mason.setup({
      -- ui = {
      --   icons = {
      --
      --   },
      -- },


    })

    mason_lspconfig.setup({
      ensure_installed = {
        "clangd",
        "lua_ls",
        "pyright",
        "bashls",
        "cmake"
      },
    })
  end,

}
