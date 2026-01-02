-- Treesitter - parsers will be installed via :TSInstall command
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  lazy = false,
  priority = 100,
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  config = function()
    -- Parsers to install (install manually with :TSInstall or :TSUpdate)
    local parsers = {
      "c", "cpp", "json", "cmake", "bash", "lua",
      "dockerfile", "vim", "vimdoc", "python",
      "rust", "go", "typescript", "javascript",
    }

    -- Check and notify if parsers need installation
    vim.defer_fn(function()
      local missing = {}
      for _, lang in ipairs(parsers) do
        if not vim.treesitter.language.get_lang(lang) then
          table.insert(missing, lang)
        end
      end

      if #missing > 0 then
        vim.notify(
          "Missing treesitter parsers. Install with: :TSInstall " .. table.concat(missing, " "),
          vim.log.levels.WARN
        )
      end
    end, 100)

    -- Enable treesitter highlighting automatically
    vim.api.nvim_create_autocmd('FileType', {
      pattern = '*',
      callback = function()
        pcall(vim.treesitter.start)
      end,
    })
  end,
}
