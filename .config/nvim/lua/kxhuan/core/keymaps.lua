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

-- "grn" is mapped in Normal mode to vim.lsp.buf.rename()
-- "gra" is mapped in Normal and Visual mode to vim.lsp.buf.code_action()
-- "grr" is mapped in Normal mode to vim.lsp.buf.references()
-- "gri" is mapped in Normal mode to vim.lsp.buf.implementation()
-- "grt" is mapped in Normal mode to vim.lsp.buf.type_definition()
-- "gO" is mapped in Normal mode to vim.lsp.buf.document_symbol()
-- CTRL-S is mapped in Insert mode to vim.lsp.buf.signature_help()

-- keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", { desc = "Show LSP references"})
-- keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
-- 
-- keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", { desc = "Show LSP definition"})
--
--opts.desc = "Show LSP definition"
--keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
--
--opts.desc = "Show LSP implementation"
--keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
--
--opts.desc = "Show LSP type definitions"
--keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)
--
--opts.desc = "Show available code actions "
--keymap.set({"n", "v"}, "<leader>ca", vim.lsp.buf.code_action, opts)
--
--opts.desc = "Smart rename"
--keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
--
--opts.desc = "Show buffer diagnostics"
--keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)
--
--opts.desc = "Show line diagnostics"
--keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
--
--opts.desc = "Go to previous diagnostic"
--keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
--
--opts.desc = "Go to next diagnostic"
--keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
--
--opts.desc = "Show documentation for what is under cursor"
--keymap.set("n", "K", vim.lsp.buf.hover, opts)
--
--opts.desc = "Restart LSP"
----     --    keymap.set("n", "<leader>rs", "LspRestart<CR>", opts)
