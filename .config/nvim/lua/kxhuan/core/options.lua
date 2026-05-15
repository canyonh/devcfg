-- Python provider - respects virtualenv if active
if vim.env.VIRTUAL_ENV then
  vim.g.python3_host_prog = vim.env.VIRTUAL_ENV .. '/bin/python3'
else
  vim.g.python3_host_prog = vim.fn.exepath('python3')
end

local opt = vim.opt

-- relative number
opt.relativenumber = true
opt.number = true

-- tab & indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

opt.wrap = false

-- search settings
opt.ignorecase = true
opt.smartcase = true

opt.cursorline = true

-- turn on termguicolors for tokyonight colorscheme to work
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- backspace
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard:append("unnamedplus")

-- split windows
opt.splitright = true
opt.splitbelow = true

-- diagnostics (virtual_text + sign icons consolidated here)
vim.diagnostic.config({
  virtual_text = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "\u{f00d}",
      [vim.diagnostic.severity.WARN] = "\u{f071}",
      [vim.diagnostic.severity.HINT] = "\u{f059}",
      [vim.diagnostic.severity.INFO] = "\u{f05a}",
    },
  },
})

vim.keymap.set('n', 'go', function()
  vim.diagnostic.config({ virtual_lines = { current_line = true }, virtual_text = true})

  vim.api.nvim_create_autocmd('CursorMoved', {
    group = vim.api.nvim_create_augroup('line-diagnostics', { clear = true }),
    callback = function()
      vim.diagnostic.config({ virtual_lines = false, virtual_text = true })
      return true
    end,
  })
end)
