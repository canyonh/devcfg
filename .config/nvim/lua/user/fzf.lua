
-- config fid fzf.vim
-- -- @todo don't know why this workspace
-- -- probably just capture it on output
-- local function set_qf_list(files)
--   for k, v in pairs(files) do
--     print(k, v)
--   end
-- end
-- 
-- vim.g.fzf_action = {
--     ['ctrl-t'] = 'tab split',
--     ['ctrl-x'] = 'split',
--     ['ctrl-v'] = 'vsplit',
--     ['alt-q']  = set_qf_list,
-- }
-- 
-- vim.g.fzf_commands_expect = 'enter'
-- vim.g.fzf_buffers_jump = 1          -- [Buffers] Jump to the existing window if possible

local actions = require "fzf-lua.actions"
require'fzf-lua'.setup {
  keymap = {
    builtin = {
      ["<S-down>"] = "preview-page-down",
      ["<S-up>"] = "preview-page-up",
    },
    fzf = {
      ["ctrl-f"] = "half-page-down",
      ["ctrl-b"] = "half-page-up",
      ["alt-a"] = "toggle-all",
      ["shift-down"] = "preview-page-down",
      ["shift-up"] = "preview-page-up",
    },
    actions = {
      files = {
        ["default"] = actions.buf_edit,
        ["ctrl-s"] = actions.buf_split,
        ["ctrl-v"] = actions.buf_vsplit,
      },
    },
  },
}
