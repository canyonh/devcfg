-- Termdebug setup and layout
vim.cmd("packadd termdebug")
vim.g["termdebug_wide"] = 163

-- Terminal navigation keymaps for termdebug GDB windows
local function set_gdb_termdebug_keymaps()
  local opts = { silent = true, buffer = 0 }
  vim.keymap.set("t", "<esc>", "<C-\\><C-N>", opts)
  vim.keymap.set("t", "<C-h>", "<C-\\><C-N><C-w>h", opts)
  vim.keymap.set("t", "<C-j>", "<C-\\><C-N><C-w>j", opts)
  vim.keymap.set("t", "<C-k>", "<C-\\><C-N><C-w>k", opts)
  vim.keymap.set("t", "<C-l>", "<C-\\><C-N><C-w>l", opts)
  vim.cmd("highlight debugPC term=reverse ctermbg=darkblue guibg=darkblue")
end

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "term://*gdb*",
  callback = set_gdb_termdebug_keymaps,
})
