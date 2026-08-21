-- Disable heavy features for large files (prevents hangs on flake.lock etc.)
-- Sets a buffer var `big_file` that treesitter and other features check.
local grp = vim.api.nvim_create_augroup("big_file", { clear = true })
vim.api.nvim_create_autocmd("BufReadPre", {
  group = grp,
  callback = function(args)
    local name = vim.api.nvim_buf_get_name(args.buf)
    local ok, stats = pcall(vim.uv.fs_stat, name)
    if ok and stats and stats.size > 512 * 1024 then
      vim.b[args.buf].big_file = true
      vim.opt_local.foldmethod = "manual"
      vim.opt_local.spell = false
    end
  end,
})
