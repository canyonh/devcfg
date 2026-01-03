-- LSP Configuration using Neovim 0.11+ Modern API
-- LSP servers are auto-installed by Mason (see mason-lspconfig.lua)
-- This file configures how LSP servers behave once installed

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",  -- LSP completion source for nvim-cmp
  },
  config = function()
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    -- Enable completion capabilities
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Diagnostic symbols in the sign column (gutter)
    vim.diagnostic.config({
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "❌",
          [vim.diagnostic.severity.WARN] = "⚠️",
          [vim.diagnostic.severity.HINT] = "💡",
          [vim.diagnostic.severity.INFO] = "ℹ️",
        },
      },
    })

    -- ============================================================================
    -- LSP Server Configurations (New API - Neovim 0.11+)
    -- Servers are installed by Mason (see mason-lspconfig.lua)
    -- ============================================================================

    -- C/C++ (clangd)
    vim.lsp.config("clangd", {
      capabilities = capabilities,
    })

    -- Python (pyright)
    vim.lsp.config("pyright", {
      capabilities = capabilities,
    })

    -- Lua (lua_ls)
    vim.lsp.config("lua_ls", {
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" }, -- Recognize 'vim' global
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
          telemetry = { enable = false },
        },
      },
    })

    -- Bash (bashls)
    vim.lsp.config("bashls", {
      capabilities = capabilities,
    })

    -- CMake (cmake)
    vim.lsp.config("cmake", {
      capabilities = capabilities,
    })

    -- YAML (yamlls)
    vim.lsp.config("yamlls", {
      capabilities = capabilities,
    })

    -- Nix (nil_ls)
    vim.lsp.config("nil_ls", {
      capabilities = capabilities,
    })

    -- JSON (jsonls)
    vim.lsp.config("jsonls", {
      capabilities = capabilities,
    })

    -- Rust (rust_analyzer)
    vim.lsp.config("rust_analyzer", {
      capabilities = capabilities,
    })

    -- TypeScript/JavaScript (ts_ls)
    vim.lsp.config("ts_ls", {
      capabilities = capabilities,
    })

    -- Enable all configured LSP servers
    vim.lsp.enable({
      "clangd", "pyright", "lua_ls", "bashls", "cmake", "yamlls",
      "nil_ls", "jsonls", "rust_analyzer", "ts_ls",
    })

    -- LspAttach autocmd for buffer-local keymaps (replaces on_attach)
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local bufnr = args.buf
        local opts = { buffer = bufnr, silent = true }

        -- These keymaps are only active when LSP is attached to the buffer
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
