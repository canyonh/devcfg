return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        current_line_blame = false,
        current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = "eol",
            delay = 300,
        },
    },
    keys = {
        { "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<CR>", desc = "Toggle git blame (virtual text)" },
    },
}
