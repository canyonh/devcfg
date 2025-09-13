return {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },
}

-- return {
--   "neovim/nvim-lspconfig",
--   event = { "BufReadPre", "BufNewFile" },
--   dependencies = {
--     "hrsh7th/cmp-nvim-lsp",
--     { "antosha417/nvim-lsp-file-operations", config = true },
--     { "folke/neodev.nvim", opts = {} },
--   },
--   config = function()
--     local lspconfig = require("lspconfig")
--     local mason_lspconfig = require("mason-lspconfig")
--     local cmp_nvim_lsp = require("cmp_nvim_lsp")
--     local keymap = vim.keymap
-- 
--     --vim.api.nvim_create_autocmd("LspAttach", {
--     --  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
--     --  callback = function(ev)
--     --    -- Buffer local mappings.
--     --    -- See ':help vim.lsp.*', for documentation
--     --    local opts = { buffer = ev.buf, silent = true}
-- 
--     --    -- keybinds
--     --    opts.desc = "Show LSP references"
--     --    keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
-- 
--     --    opts.desc = "Go to declaration"
--     --    keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
-- 
--     --    opts.desc = "Show LSP definition"
--     --    keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
-- 
--     --    opts.desc = "Show LSP implementation"
--     --    keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
-- 
--     --    opts.desc = "Show LSP type definitions"
--     --    keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)
-- 
--     --    opts.desc = "Show available code actions "
--     --    keymap.set({"n", "v"}, "<leader>ca", vim.lsp.buf.code_action, opts)
-- 
--     --    opts.desc = "Smart rename"
--     --    keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
-- 
--     --    opts.desc = "Show buffer diagnostics"
--     --    keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)
-- 
--     --    opts.desc = "Show line diagnostics"
--     --    keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
-- 
--     --    opts.desc = "Go to previous diagnostic"
--     --    keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
-- 
--     --    opts.desc = "Go to next diagnostic"
--     --    keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
-- 
--     --    opts.desc = "Show documentation for what is under cursor"
--     --    keymap.set("n", "K", vim.lsp.buf.hover, opts)
-- 
--     --    opts.desc = "Restart LSP"
--     --    keymap.set("n", "<leader>rs", "LspRestart<CR>", opts)
--     --  end,
--     --})
-- 
--     local capabilities = cmp_nvim_lsp.default_capabilities()
--     -- Change the Diagnostic symbols in the sign column (gutter)
--     -- (not in youtube nvim video)
--     local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
--     for type, icon in pairs(signs) do
--       local hl = "DiagnosticSign" .. type
--       vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
--     end
-- 
--     mason_lspconfig.setup_handlers({
--       function(server_name)
--         lspconfig[server_name].setup({
--           capabilities = capabilities
--         })
--       end,
--       -- custom lsp setup functions example
--       -- ["svelte"] = function()
--       --   -- configure svelte server
--       --   lspconfig["svelte"].setup({
--       --     capabilities = capabilities,
--       --     on_attach = function(client, bufnr)
--       --       vim.api.nvim_create_autocmd("BufWritePost", {
--       --         pattern = { "*.js", "*.ts" },
--       --         callback = function(ctx)
--       --           -- Here use ctx.match instead of ctx.file
--       --           client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
--       --         end,
--       --       })
--       --     end,
--       --   })
--     })
--   end,
--  }






