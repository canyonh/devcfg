vim.o.termguicolors = true

require "user.options"
require "user.keymaps"
require "user.plugins"
require "user.colorscheme"
require "user.cmp"
require "user.lsp"
require "user.telescope"
require "user.treesitter"
require "user.autopairs"
require "user.gitsigns"
require "user.toggleterm"
require "user.dap"

vim.cmd "colorscheme duskfox"
