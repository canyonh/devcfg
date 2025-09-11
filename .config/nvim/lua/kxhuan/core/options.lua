vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

-- relative number
opt.relativenumber = true
opt.number = true

-- tab & indentation
opt.tabstop = 4 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 4 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting a new one

opt.wrap = false

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if mixed case is included in the search, assume you want case-sensitive

opt.cursorline = true

-- turn on termguicolors for tokyonight colorscheme to work
opt.termguicolors = true
opt.background = "dark" -- light/dark
opt.signcolumn = "yes" -- show sign column so text does not shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- lsp options
-- vim.diagnostic.config({
--     virtual_text = true,
--     virtual_lines = { current_line = true },
--     --underline = true,
--     --update_in_insert = false
-- })

--local function jumpWithVirtLineDiags(jumpCount)
--	pcall(vim.api.nvim_del_augroup_by_name, "jumpWithVirtLineDiags") -- prevent autocmd for repeated jumps
--
--	vim.diagnostic.jump { count = jumpCount }
--
--	local initialVirtTextConf = vim.diagnostic.config().virtual_text
--	vim.diagnostic.config {
--		virtual_text = false,
--		virtual_lines = { current_line = true },
--	}
--
--	vim.defer_fn(function() -- deferred to not trigger by jump itself
--		vim.api.nvim_create_autocmd("CursorMoved", {
--			desc = "User(once): Reset diagnostics virtual lines",
--			once = true,
--			group = vim.api.nvim_create_augroup("jumpWithVirtLineDiags", {}),
--			callback = function()
--				vim.diagnostic.config { virtual_lines = false, virtual_text = initialVirtTextConf }
--			end,
--		})
--	end, 1)
--end
--
--vim.keymap.set("n", "ge", function() jumpWithVirtLineDiags(1) end, { desc = "󰒕 Next diagnostic" })
--vim.keymap.set("n", "gE", function() jumpWithVirtLineDiags(-1) end, { desc = "󰒕 Prev diagnostic" })

vim.diagnostic.config({
    virtual_text = true,
    -- virtual_lines = { current_line = true },
    --underline = true,
    --update_in_insert = false
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

