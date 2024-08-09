local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Add trerm debug and setting its layout
vim.cmd "packadd termdebug"
vim.g["termdebug_wide"] = 163

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- My plugins here
  "nvim-neotest/nvim-nio", -- async io library for neo vim
  "nvim-lua/popup.nvim", -- An implementation of the Popup API from vim in Neovim
  "nvim-lua/plenary.nvim", -- Useful lua functions used ny lots of plugins
  "windwp/nvim-autopairs", -- Autopairs, integrates with both cmp and snippets
  "akinsho/toggleterm.nvim",

  -- nvim trees and icons
  {
    "nvim-tree/nvim-tree.lua",
    version ="*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup {}
    end,
  },

  -- bufferline
  --{
  --  "akinsho/bufferline.nvim",
  --  version = "*",
  --  dependencies = 'nvim-tree/nvim-web-devicons',
  --  config = function()
  --    require("bufferline").setup{}
  --  end,
  --},
  "moll/vim-bbye",

  -- Colorschemes
  -- use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out
  "lunarvim/darkplus.nvim",
  "EdenEast/nightfox.nvim",
  "folke/tokyonight.nvim",
  "savq/melange",
  "sainnhe/sonokai",
  "sainnhe/everforest",
  "ellisonleao/gruvbox.nvim",

  -- cmp plugins
  "hrsh7th/nvim-cmp", -- The completion plugin
  "hrsh7th/cmp-buffer", -- buffer completions
  "hrsh7th/cmp-path", -- path completions
  "hrsh7th/cmp-cmdline", -- cmdline completions
  "saadparwaiz1/cmp_luasnip", -- snippet completions
  "hrsh7th/cmp-nvim-lsp",

  -- snippets
  -- "L3MON4D3/LuaSnip", --snippet engine
  -- "rafamadriz/friendly-snippets", -- a bunch of snippets to use

  -- LSP
  -- Note the following 3 plug-ins need to be in this order
  "williamboman/mason.nvim", -- simple to use language server installer
  "williamboman/mason-lspconfig.nvim", -- simple to use language server installer
  "neovim/nvim-lspconfig", -- enable LSP

  "jose-elias-alvarez/null-ls.nvim", -- for formatters and linters

  {
    'ibhagwan/fzf-lua',
    dependencies = { "nvim-tree/nvim-web-devicons"},
    config = function()
      require("fzf-lua").setup({})
    end
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  -- deprecated
  -- "p00f/nvim-ts-rainbow",
  -- "nvim-treesitter/playground",

  -- DAP
  --"mfussenegger/nvim-dap",
  --{
  --  -- Install parser for treee-sitter python
  --  "mfussenegger/nvim-dap-python",
  --  build = ":TSInstall python",
  --  dependencies= { "mfussenegger/nvim-dap" }
  --},

  -- {
  --   "rcarriga/nvim-dap-ui",
  --   dependencies = { "mfussenegger/nvim-dap" }
  -- },
  --
  -- {
  --   "theHamsta/nvim-dap-virtual-text",
  --   dependencies = { "mfussenegger/nvim-dap" }
  -- },

  -- {
  --   "mxsdev/nvim-dap-vscode-js",
  --   dependencies = { "mfussenegger/nvim-dap" }
  -- },
  -- git
  "lewis6991/gitsigns.nvim",

  -- tmux
  -- @todo does not work when nvim-tree is opened
  {
    "alexghergh/nvim-tmux-navigation",
    config = function()
    local nvim_tmux_nav = require('nvim-tmux-navigation')
    nvim_tmux_nav.setup {
      disable_when_zoomed = true -- defaults to false
    }
    vim.keymap.set('n', "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
    vim.keymap.set('n', "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
    vim.keymap.set('n', "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
    vim.keymap.set('n', "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
    -- this will conflict with toggle term
    --      vim.keymap.set('n', "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
    --      vim.keymap.set('n', "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)
    end
  }
})
