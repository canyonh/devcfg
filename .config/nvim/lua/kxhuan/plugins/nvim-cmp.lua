return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer", -- completion source from text in the buffers
    "hrsh7th/cmp-path", -- completion source from file system paths
    "hrsh7th/cmp-nvim-lsp", -- completion source from lsp 
  },
  config = function()
    local cmp = require("cmp")
    local auto_select = true
    cmp.setup({
      completion = {
        completeopt = "menu,menuone, preview,noselect",
      },


      mapping = cmp.mapping.preset.insert({
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
      }),

      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        -- { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
      }),
    })
  end,
}
