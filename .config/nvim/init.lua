vim.o.termguicolors = true

require "user.options"
require "user.keymaps"
require "user.plugins"
require "user.colorscheme"
require "user.cmp"
require "user.lsp"
-- telescopee is too slow
--require "user.telescope"
require "user.fzf"
require "user.treesitter"
require "user.autopairs"
require "user.gitsigns"
require "user.toggleterm"
require "user.dap"
require "user.nvim-tree"
require "user.bufferline"

vim.cmd "colorscheme sonokai"
