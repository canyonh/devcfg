local configs = require("nvim-treesitter.configs")
configs.setup {
  -- ensure_installed = "maintained",
  ensure_installed = { 'python', 'cpp', 'bash', 'json', 'javascript', 'java', 'lua', 'vimdoc' },
  sync_install = false,
  ignore_install = { "" }, -- List of parsers to ignore installing
  autopairs = {
    enable = true,
  },
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "" }, -- list of language that will be disabled
    -- additional_vim_regex_highlighting = true,
    -- additional_vim_regex_highlighting = false,
  },
  -- indent = { enable = true, disable = { "yaml" } },
  -- indent is messing with c++ files
  -- indent = { enable = false },

  -- rainbow = {
  --  enable = true,
  --  -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
  --  extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
  --  max_file_lines = nil, -- Do not enable for files with more than n lines, int
  --  -- colors = {}, -- table of hex strings
  --  -- termcolors = {} -- table of colour name strings
  --}

}
