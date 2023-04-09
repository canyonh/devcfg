local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
-- keymap("", "<Space>", "<Nop>", opts)
-- vim.g.mapleader = " "
-- vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Not useful? perhaps covered by tmux?
-- Better window navigation
--keymap("n", "<C-h>", "<C-w>h", opts)
--keymap("n", "<C-j>", "<C-w>j", opts)
--keymap("n", "<C-k>", "<C-w>k", opts)
--keymap("n", "<C-l>", "<C-w>l", opts)

-- nvim-tree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Move text up and down
-- keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
-- keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Insert --
-- Press jk fast to enter
-- keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
-- keymap("v", "<", "<gv", opts)
-- keymap("v", ">", ">gv", opts)

-- Move text up and down
-- keymap("v", "<A-j>", ":m .+1<CR>==", opts)
-- keymap("v", "<A-k>", ":m .-2<CR>==", opts)


-- @todo is it useful?
-- keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
-- keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
-- keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
-- keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
-- keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation for termdebug 
function _G.set_gdb_termdebug_keymaps()
  keymap("t", "<esc>", "<C-\\><C-N>", term_opts)
  keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
  keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
  keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
  keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
  vim.cmd [[highlight debugPC term=reverse ctermbg=darkblue guibg=darkblue]]
end
vim.cmd('autocmd! TermOpen term://*gdb* lua set_gdb_termdebug_keymaps()')

-- Telescope (too slow)
-- keymap("n", "<c-p>", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>", opts)
-- keymap("n", "<c-n>", "<cmd>Telescope live_grep<cr>", opts)

-- for fzf
keymap("n", "<c-p>", "<cmd>lua require('fzf-lua').files()<cr>", opts)
keymap("n", "<c-n>", "<cmd>lua require('fzf-lua').live_grep()<cr>", opts)

-- find files
keymap("n", "<leader>ff", "<cmd>lua require('fzf-lua').files()<cr>", opts)

-- vcs files, commits branches
keymap("n", "<leader>vf", "<cmd>lua require('fzf-lua').git_files()<cr>", opts)
keymap("n", "<leader>vc", "<cmd>lua require('fzf-lua').git_commits()<cr>", opts)
keymap("n", "<leader>vb", "<cmd>lua require('fzf-lua').git_branches()<cr>", opts)

-- grep live, grep buffer
keymap("n", "<leader>gl", "<cmd>lua require('fzf-lua').live_grep()<cr>", opts)
keymap("n", "<leader>gb", "<cmd>lua require('fzf-lua').blines()<cr>", opts)
keymap("n", "<leader>go", "<cmd>lua require('fzf-lua').buffers()<cr>", opts)

-- wworksapce symbols, workspace diagnostics
keymap("n", "<leader>ws", "<cmd>lua require('fzf-lua').lsp_live_workspace_symbols()<cr>", opts)
keymap("n", "<leader>wd", "<cmd>lua require('fzf-lua').lsp_workspace_diagnostics()<cr>", opts)

-- document symbol and diagnostics
keymap("n", "<leader>ds", "<cmd>lua require('fzf-lua').lsp_document_symbols()<cr>", opts)
keymap("n", "<leader>dd", "<cmd>lua require('fzf-lua').lsp_document_diagnostics()<cr>", opts)

-- DAP
keymap("n", "<F5>", "<cmd>lua require'dap'.continue()<cr>", opts)
keymap("n", "<F6>", "<cmd>lua require'dap'.terminate()<cr>", opts)
keymap("n", "<F9>", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)

keymap("n", "<F10>", "<cmd>lua require'dap'.step_over()<cr>", opts)
keymap("n", "<F11>", "<cmd>lua require'dap'.step_into()<cr>", opts)
keymap("n", "<F12>", "<cmd>lua require'dap'.step_out()<cr>", opts)
keymap("n", "<F6>", "<cmd>lua require'dapui'.toggle()<cr>", opts)
keymap("n", "<F7>", "<cmd>lua require'dap'.repl.toggle()<cr>", opts)

-- todo make a command
-- remove all non-printable char %s/[^[:print:]]//g
