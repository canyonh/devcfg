-- Add trerm debug and setting its layout
vim.cmd "packadd termdebug"
vim.g["termdebug_wide"] = 163

-- Better terminal navigation for termdebug 
local term_opts = { silent = true }
local keymap = vim.api.nvim_set_keymap

function _G.set_gdb_termdebug_keymaps()
  keymap("t", "<esc>", "<C-\\><C-N>", term_opts)
  keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
  keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
  keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
  keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
  vim.cmd [[highlight debugPC term=reverse ctermbg=darkblue guibg=darkblue]]
end

vim.cmd('autocmd! TermOpen term://*gdb* lua set_gdb_termdebug_keymaps()')
