return {
  "monkoose/neocodeium",
  event = "VeryLazy",
  opts = {
    server =  {
      portal_url = "https://codeium.itools.anduril.dev",
      api_url = "https://codeium.itools.anduril.dev/_route/api_server",
    }
  },
  config = function()
    local neocodeium = require("neocodeium")
    neocodeium.setup()
    vim.keymap.set("i", "<A-f>", neocodeium.accept)
  end,
}
