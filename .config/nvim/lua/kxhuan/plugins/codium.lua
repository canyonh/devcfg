return {
  "Exafunction/codeium.nvim",
  event = "BufEnter",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
  config = function()
    require("codeium").setup({})
    vim.cmd[[let g:codeium_server_config = { 'portal_url': 'https://codeium.anduril.dev', 'api_url': 'https://codeium.anduril.dev/_route/api_server' } ]]
  end
}
