return {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },
    config = function()
        local mason_lspconfig = require("mason-lspconfig")

        -- Auto-install LSP servers
        -- Note: LSP server configuration is in lsp/lspconfig.lua
        -- Mason only handles installation here
        mason_lspconfig.setup({
            -- List of LSP servers to automatically install
            ensure_installed = {
                "clangd",        -- C/C++ (for dive-xl-payloads, etc.)
                "pyright",       -- Python (for pybt, autonomy-divexl, test scripts)
                "lua_ls",        -- Lua (for neovim config)
                "bashls",        -- Bash
                "cmake",         -- CMake
                "jsonls",        -- JSON
                "yamlls",        -- YAML
                "rust_analyzer", -- Rust
                "ts_ls",         -- TypeScript/JavaScript
                "nil_ls",        -- Nix
            },
            -- Auto-install any servers configured in lspconfig but not manually installed
            automatic_installation = true,
        })
    end,
}
