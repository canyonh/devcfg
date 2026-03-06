return {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
        {
            "mason-org/mason.nvim",
            opts = {
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
                },
            },
        },
        "neovim/nvim-lspconfig",
    },
    config = function()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "clangd",
                "pyright",
                "lua_ls",
                "bashls",
                "cmake",
                "jsonls",
                "yamlls",
                "rust_analyzer",
                "ts_ls",
            },
            automatic_installation = true,
        })
    end,
}
