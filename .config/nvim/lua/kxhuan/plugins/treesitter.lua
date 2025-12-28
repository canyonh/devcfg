-- Treesitter is managed by lazy.nvim
-- NOTE: nvim-treesitter was completely rewritten - new API uses Neovim built-in features
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",  -- Auto-update parsers on plugin update
  lazy = false,  -- Load immediately (before other plugins need it)
  priority = 100,  -- Load early but after colorscheme
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  config = function()
    -- Install parsers (new API)
    require('nvim-treesitter').install({
      "c",
      "cpp",
      "json",
      "cmake",
      "bash",
      "lua",
      "dockerfile",
      "vim",
      "vimdoc",
      "python",
    })

    -- Enable treesitter highlighting for all filetypes (replaces old highlight.enable)
    vim.api.nvim_create_autocmd('FileType', {
      pattern = '*',
      callback = function()
        local ok = pcall(vim.treesitter.start)
        if not ok then
          -- Silently ignore files without treesitter support
        end
      end,
    })
  end,
}
