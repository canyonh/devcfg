-- DAP_PYTHON
-- require('dap-python').setup(os.getenv("VIRTUAL_ENV") .. "/bin/python")
local dap = require('dap')
local dapui = require('dapui')

require('dap-python').setup("python")
local dap_virtual_text = require('nvim-dap-virtual-text')

dapui.setup({
  icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
  controls = {
    --enabled = true,
    enabled = false,
    -- Display controls in this element
    element = "repl",
    icons = {
      pause = "",
      play = "",
      step_into = "",
      step_over = "",
      step_out = "",
      step_back = "",
      run_last = "↻",
      terminate = "X",
    },
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "single", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
})

dap_virtual_text.setup {
    enabled = true,                        -- enable this plugin (the default)
    enabled_commands = true,               -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
    highlight_changed_variables = true,    -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
    highlight_new_as_changed = false,      -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
    show_stop_reason = true,               -- show stop reason when stopped for exceptions
    commented = false,                     -- prefix virtual text with comment string
    only_first_definition = true,          -- only show virtual text at first definition (if there are multiple)
    all_references = false,                -- show virtual text on all all references of the variable (not only definitions)
    clear_on_continue = false,             -- clear virtual text on "continue" (might cause flickering when stepping)
    --- A callback that determines how a variable is displayed or whether it should be omitted
    --- @param variable Variable https://microsoft.github.io/debug-adapter-protocol/specification#Types_Variable
    --- @param buf number
    --- @param stackframe dap.StackFrame https://microsoft.github.io/debug-adapter-protocol/specification#Types_StackFrame
    --- @param node userdata tree-sitter node identified as variable definition of reference (see `:h tsnode`)
    --- @param options nvim_dap_virtual_text_options Current options for nvim-dap-virtual-text
    --- @return string|nil A text how the virtual text should be displayed or nil, if this variable shouldn't be displayed
    display_callback = function(variable, buf, stackframe, node, options)
    -- by default, strip out new line characters
      if options.virt_text_pos == 'inline' then
        return ' = ' .. variable.value:gsub("%s+", " ")
      else
        return variable.name .. ' = ' .. variable.value:gsub("%s+", " ")
      end
    end,
    -- position of virtual text, see `:h nvim_buf_set_extmark()`, default tries to inline the virtual text. Use 'eol' to set to end of line
    virt_text_pos = vim.fn.has 'nvim-0.10' == 1 and 'inline' or 'eol',

    -- experimental features:
    all_frames = false,                    -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
    virt_lines = false,                    -- show virtual lines instead of virtual text (will flicker!)
    virt_text_win_col = nil                -- position the virtual text at a fixed window column (starting from the first text column) ,
}

dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

-- Define custom signs for nvim-dap
vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#993939', bg = '#31353f' })
vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = '#61afef', bg = '#31353f' })
vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#98c379', bg = '#31353f' })

vim.fn.sign_define('DapBreakpoint', {text='●', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint'})
vim.fn.sign_define('DapStopped', {text='', texthl='DapStopped', linehl='DapStopped', numhl='DapStopped'})
vim.fn.sign_define('DapBreakpointRejected', {text='❌', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint'})
vim.fn.sign_define('DapLogPoint', {text='X', texthl='DapLogPoint', linehl='DapLogPoint', numhl='DapLogPoint'})


-- vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#993939', bg = '#31353f' })
-- vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = '#61afef', bg = '#31353f' })
-- vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#98c379', bg = '#31353f' })
-- local venv_python_path = string.format("%s/bin/python", os.getenv("VIRTUAL_ENV"))
-- require('dap-python').setup(venv_python_path)
-- mason registry - get information about installed packages
-- local mason_registry = require('mason-registry')
-- DAP vscode-js-debug
--
-- require("dap-vscode-js").setup({
--   -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
--   -- debugger_path = "(runtimedir)/site/pack/packer/opt/vscode-js-debug", -- Path to vscode-js-debug installation.
-- 
--   -- this is the full list, we only use the first one now
--   -- adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
--   adapters = { 'pwa-node' }
-- })

-- for _, language in ipairs({ "typescript", "javascript" }) do
--   require("dap").configurations[language] = {
--     -- node js
--     {
--       type = "pwa-node",
--       request = "launch",
--       name = "Launch file",
--       program = "${file}",
--       cwd = "${workspaceFolder}",
--     },
--     {
--       type = "pwa-node",
--       request = "attach",
--       name = "Attach",
--       processId = require 'dap.utils'.pick_process,
--       cwd = "${workspaceFolder}",
--     },
--     -- Jest
--     {
--       type = "pwa-node",
--       request = "launch",
--       name = "Debug Jest Tests",
--       -- trace = true, -- include debugger info
--       runtimeExecutable = "node",
--       runtimeArgs = {
--         "./node_modules/jest/bin/jest.js",
--         "--runInBand",
--       },
--       rootPath = "${workspaceFolder}",
--       cwd = "${workspaceFolder}",
--       console = "integratedTerminal",
--       internalConsoleOptions = "neverOpen",
--     },
--   }
-- end

-- DAP vscode cpptools
-- local cpptools= mason_registry.get_package("cpptools")
-- print(cpptools:get_install_path())

-- local dap = require('dap')
--dap.adapters.cppdbg = {
--  id = 'cppdbg',
--  type = 'executable',
--  -- command = '/home/kxhuan/.local/share/nvim/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7',
--  command = cpptools:get_install_path() .. '/extension/debugAdapters/bin/OpenDebugAD7'
--}
--
--dap.configurations.cpp = {
--  {
--    name = "Launch file",
--    type = 'cppdbg',
--    request = 'launch',
--    program = function()
--      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file' )
--    end,
--    cwd = '${workspaceFolder}',
--    stopAtEntry = true,
--    setupCommands = {
--      {
--        text = 'source ${workspaceFolder}/.gdbinit',
--        ignoreFailures = 'true',
--      },
--      {
--        text = '-enable-pretty-printing',
--        ignoreFailures = 'true',
--      }
--    }
--  },
--  {
--    name = 'Attach to gdbserver :1234',
--    type = 'cppdbg',
--    request = 'launch',
--    MIMode = 'gdb',
--    miDebuggerServerAddress = 'localhost:1234',
--    miDebuggerPath = '/usr/bin/gdb',
--    cwd = '${workspaceFolder}',
--    pid = require('dap.utils').pick_process,
--    args = {},
--    setupCommands = {
--      {
--        text = 'source ${workspaceFolder}/.gdbinit',
--        ignoreFailures = 'true',
--      },
--      {
--        text = '-enable-pretty-printing',
--        ignoreFailures = 'true',
--      }
--    }
--  }
--}
--

-- DAP UI
-- require("dapui").setup({
--   icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
--   mappings = {
--     -- Use a table to apply multiple mappings
--     expand = { "<CR>", "<2-LeftMouse>" },
--     open = "o",
--     remove = "d",
--     edit = "e",
--     repl = "r",
--     toggle = "t",
--   },
--   -- Expand lines larger than the window
--   -- Requires >= 0.7
--   expand_lines = vim.fn.has("nvim-0.7"),
--   -- Layouts define sections of the screen to place windows.
--   -- The position can be "left", "right", "top" or "bottom".
--   -- The size specifies the height/width depending on position. It can be an Int
--   -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
--   -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
--   -- Elements are the elements shown in the layout (in order).
--   -- Layouts are opened in order so that earlier layouts take priority in window sizing.
--   layouts = {
--     {
--       elements = {
--         -- Elements can be strings or table with id and size keys.
--         { id = "scopes", size = 0.25 },
--         "breakpoints",
--         "stacks",
--         "watches",
--       },
--       size = 40, -- 40 columns
--       position = "left",
--     },
--     {
--       elements = {
--         "repl",
--         "console",
--       },
--       size = 0.25, -- 25% of total lines
--       position = "bottom",
--     },
--   },
--   controls = {
--     enabled = true,
--     -- Display controls in this element
--     element = "repl",
--     icons = {
--       pause = "",
--       play = "",
--       step_into = "",
--       step_over = "",
--       step_out = "",
--       step_back = "",
--       run_last = "↻",
--       terminate = "□",
--     },
--   },
--   floating = {
--     max_height = nil, -- These can be integers or a float between 0 and 1.
--     max_width = nil, -- Floats will be treated as percentage of your screen.
--     border = "single", -- Border style. Can be "single", "double" or "rounded"
--     mappings = {
--       close = { "q", "<Esc>" },
--     },
--   },
--   windows = { indent = 1 },
--   render = {
--     max_type_length = nil, -- Can be integer or nil.
--     max_value_lines = 100, -- Can be integer or nil.
--   }
-- })
-- 
-- -- -- auto close and open dap ui
-- local dapui =  require("dapui")
-- dap.listeners.after.event_initialized["dapui_config"] = function()
--   dapui.open()
-- end
-- dap.listeners.before.event_terminated["dapui_config"] = function()
--   dapui.close()
-- end
-- dap.listeners.before.event_exited["dapui_config"] = function()
--   dapui.close()
-- end
-- 
-- -- DAP virtual test
-- require("nvim-dap-virtual-text").setup {
--   enabled = true, -- enable this plugin (the default)
--   enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
--   highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
--   highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
--   show_stop_reason = true, -- show stop reason when stopped for exceptions
--   commented = false, -- prefix virtual text with comment string
--   only_first_definition = true, -- only show virtual text at first definition (if there are multiple)
--   all_references = false, -- show virtual text on all all references of the variable (not only definitions)
--   filter_references_pattern = '<module', -- filter references (not definitions) pattern when all_references is activated (Lua gmatch pattern, default filters out Python modules)
--   -- experimental features:
--   virt_text_pos = 'eol', -- position of virtual text, see `:h nvim_buf_set_extmark()`
--   all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
--   virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
--   virt_text_win_col = nil -- position the virtual text at a fixed window column (starting from the first text column) ,
--   -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
-- }
