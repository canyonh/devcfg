-- vim.cmd [[
-- try
--   colorscheme darkplus
-- catch /^Vim\%((\a\+)\)\=:E185/
--   colorscheme default
--   set background=dark
-- endtry
-- ]]

require("tokyonight").setup({
  transparent = false,
  terminal_colros = true,
  on_colors = function(colors)
    colors.diff = {
      add = "#005600", -- "#41a6b5",
      delete = "#c53b53",
      change = "#000490", -- "#394b70",
      text  = "#be00b9"-- "#394b70"
    }
  end,
  -- on_highlights = function(highlights, colors)
  -- end
})

vim.cmd([[:highlight debugPC term=reverse ctermbg=darkblue guibg=darkblue]])
