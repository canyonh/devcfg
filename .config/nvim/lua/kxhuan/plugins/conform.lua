return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
    opts = {
        formatters_by_ft = {
            css = { "prettierd" },
            html = { "prettierd" },
            javascript = { "prettierd" },
            javascriptreact = { "prettierd" },
            json = { "prettierd" },
            lua = { "stylua" },
            markdown = { "prettierd" },
            sh = { "shfmt" },
            python = { "ruff_organize_imports", "ruff_fix", "ruff_format" },
            typescript = { "prettierd" },
            typescriptreact = { "prettierd" },
            yaml = { "prettierd" },
        },
    },
    vim.keymap.set({ "n", "v" }, "<leader>gf", function()
        require('conform').format({
            lsp_fallback = true,
            async = false,
            timeout_ms = 500,
        })
    end, { desc = "Format file or range (in visual mode)" })
}
