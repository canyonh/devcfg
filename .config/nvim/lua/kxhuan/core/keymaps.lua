-- vim.g.mapleader = ' '
local keymap = vim.keymap -- for conciseness

-- keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" } )
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increase/decrease numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increament number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make split equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })


-- tabs
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current tab in a new tab" })
keymap.set("n", "gd", vim.lsp.buf.declaration, { desc = "Go to declaration" })

-- Without telescope it seems to be faster
-- keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", { desc = "Show LSP references"})

keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
keymap.set("n", "ga", vim.lsp.buf.code_action, { desc = "Go to implementation" })
keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Go to implementation" })

-- TODO(khuang) make range format work
-- keymap.set("v", "<leader>gf", vim.lsp.buf.format, { desc = "Range formatting" })
