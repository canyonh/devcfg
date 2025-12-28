return {
  "rcarriga/nvim-dap-ui",
  dependencies = {
    "mfussenegger/nvim-dap",
    "theHamsta/nvim-dap-virtual-text",
    "nvim-neotest/nvim-nio",
    --"mfussenegger/nvim-dap-python",
  },
  config = function()
    local dap = require("dap")
     -- local dap_python = require("dap-python")
    local dapui = require("dapui")
    local dap_virtual_text = require("nvim-dap-virtual-text")

    dapui.setup({
      icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
      controls = {
        --enabled = true,
        enabled = false,
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

    dap_virtual_text.setup({
        enabled = true,                        -- enable this plugin (the default)
        enabled_commands = true,               -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
        highlight_changed_variables = true,    -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
        highlight_new_as_changed = false,      -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
        show_stop_reason = true,               -- show stop reason when stopped for exceptions
        commented = false,                     -- prefix virtual text with comment string
        only_first_definition = true,          -- only show virtual text at first definition (if there are multiple)
        all_references = false,                -- show virtual text on all all references of the variable (not only definitions)
        clear_on_continue = false,             -- clear virtual text on "continue" (might cause flickering when stepping)
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
    })

    dap.listeners.before.attach.dapui_config = function(session, body)
      dapui.open()
    end

    dap.listeners.before.launch.dapui_config = function(session, body)
      dapui.open()
    end

    dap.listeners.before.event_terminated.dapui_config = function(session, body)
      dapui.close()
    end

    dap.listeners.before.event_exited.dapui_config = function(session, body)
      dapui.close()
    end

    -- Suppress debugpySockets warnings (these are informational events we don't need)
    dap.listeners.before.event_debugpySockets.dapui_config = function(session, body)
      -- Silently ignore this event
    end

    -- Define custom signs for nvim-dap
    vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#993939', bg = '#31353f' })
    vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = '#61afef', bg = '#31353f' })
    vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#98c379', bg = '#31353f' })

    vim.fn.sign_define('DapBreakpoint', {text='●', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint'})
    vim.fn.sign_define('DapStopped', {text='', texthl='DapStopped', linehl='DapStopped', numhl='DapStopped'})
    vim.fn.sign_define('DapBreakpointRejected', {text='❌', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint'})
    vim.fn.sign_define('DapLogPoint', {text='X', texthl='DapLogPoint', linehl='DapLogPoint', numhl='DapLogPoint'})

    -- DAP
    local keymap = vim.keymap
    keymap.set("n", "<F5>", "<cmd>lua require'dap'.continue()<cr>", { desc = "DAP: continue"})
    keymap.set("n", "<F6>", "<cmd>lua require'dap'.terminate()<cr>",{ desc = "DAP: terminate"})
    keymap.set("n", "<F9>", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", { desc = "DAP: toggle breakpoint"})
    keymap.set("n", "<F10>", "<cmd>lua require'dap'.step_over()<cr>", { desc = "DAP: step over"})
    keymap.set("n", "<F11>", "<cmd>lua require'dap'.step_into()<cr>", { desc = "DAP: step into"})
    keymap.set("n", "<F12>", "<cmd>lua require'dap'.step_out()<cr>", { desc = "DAP: step out"})

    -- Debugger adapters - https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
    dap.adapters.gdb = {
      type = "executable",
      command = "gdb",
      args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
    }

    dap.adapters.python = function(callback, config)
      local python_path = vim.env.VIRTUAL_ENV and (vim.env.VIRTUAL_ENV .. '/bin/python3') or 'python3'
      callback({
        type = 'executable',
        command = python_path,
        args = { '-m', 'debugpy.adapter' },
      })
    end

    -- Determine Python path once at config time
    local python_path = 'python3'
    if vim.env.VIRTUAL_ENV then
      python_path = vim.env.VIRTUAL_ENV .. '/bin/python3'
    end

    dap.configurations.python= {
      {
        name= "Pytest: Current File",
        type= "python",
        request= "launch",
        module= "pytest",
        args= function()
          return {
            vim.fn.expand('%:p'),  -- Full path to current file
            "-sv",
            "--log-cli-level=INFO",
            "--log-file=test_out.log"
          }
        end,
        console= "integratedTerminal",  -- Use integrated terminal for better output visibility
        justMyCode= false,               -- Allow debugging into library code
        cwd= "${workspaceFolder}",       -- Run from project root
        stopOnEntry= false,
        pythonPath= python_path,         -- Use virtualenv Python (evaluated at config load)
        env= {
          PYTHONPATH = vim.env.PYTHONPATH,  -- Critical: Pass PYTHONPATH so pytest finds modules
          VIRTUAL_ENV = vim.env.VIRTUAL_ENV,
        },
      }
    }

    dap.configurations.cpp = {
      {
        name = "Launch",
        type = "gdb",
        request = "launch",
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = "${workspaceFolder}",
        stopAtBeginningOfMainSubprogram = false,
      },
      {
        name = "Select and attach to process",
        type = "gdb",
        request = "attach",
        program = function()
           return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        pid = function()
           local name = vim.fn.input('Executable name (filter): ')
           return require("dap.utils").pick_process({ filter = name })
        end,
        cwd = '${workspaceFolder}'
      },
      {
        name = 'Attach to gdbserver :1234',
        type = 'gdb',
        request = 'attach',
        target = 'localhost:1234',
        program = function()
           return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}'
      },
    }

    -- Auto-load project-specific DAP configurations
    -- Try to load VSCode launch.json files if they exist
    local function try_load_vscode_launch()
      local paths = {
        vim.fn.getcwd() .. '/.vscode/launch.json',
        vim.fn.getcwd() .. '/.vscode_shared/launch.json',
      }

      for _, path in ipairs(paths) do
        if vim.fn.filereadable(path) == 1 then
          -- Use pcall to safely attempt loading, may fail for complex configs
          local ok, err = pcall(require('dap.ext.vscode').load_launchjson, path)
          if ok then
            vim.notify("Loaded DAP configurations from " .. vim.fn.fnamemodify(path, ':~:.'), vim.log.levels.INFO)
          else
            -- Silently fail - VSCode configs may have unsupported features
            -- Users can create .nvim.lua for complex scenarios
          end
          return true
        end
      end
      return false
    end

    -- Defer loading to ensure all adapters are registered
    vim.defer_fn(function()
      try_load_vscode_launch()
    end, 100)
  end
}
