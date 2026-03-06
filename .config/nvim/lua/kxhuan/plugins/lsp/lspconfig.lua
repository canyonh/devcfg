-- LSP Configuration using Neovim 0.11+ Modern API
-- LSP servers are auto-installed by Mason (see mason-lspconfig.lua)
-- Diagnostic signs/virtual_text are configured in core/options.lua

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Servers that only need capabilities (no custom settings)
    local default_servers = {
      "clangd", "pyright", "bashls", "cmake", "yamlls",
      "nil_ls", "jsonls", "rust_analyzer", "ts_ls",
    }

    for _, server in ipairs(default_servers) do
      vim.lsp.config(server, { capabilities = capabilities })
    end

    -- Lua needs custom settings for neovim development
    vim.lsp.config("lua_ls", {
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
          telemetry = { enable = false },
        },
      },
    })

    -- Enable all configured LSP servers
    local all_servers = vim.list_extend({ "lua_ls" }, default_servers)
    vim.lsp.enable(all_servers)

    -- Buffer-local keymaps (replaces on_attach)
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local bufnr = args.buf
        local opts = { buffer = bufnr, silent = true }

        vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
        vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", vim.tbl_extend("force", opts, { desc = "Show LSP references" }))
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
        vim.keymap.set("n", "ga", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code actions" }))
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
      end,
    })
  end,
}
