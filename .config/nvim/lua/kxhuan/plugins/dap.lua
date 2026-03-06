return {
  "rcarriga/nvim-dap-ui",
  dependencies = {
    "mfussenegger/nvim-dap",
    "theHamsta/nvim-dap-virtual-text",
    "nvim-neotest/nvim-nio",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    local dap_virtual_text = require("nvim-dap-virtual-text")

    dapui.setup({
      icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
      controls = {
        enabled = false,
      },
      floating = {
        max_height = nil,
        max_width = nil,
        border = "single",
        mappings = {
          close = { "q", "<Esc>" },
        },
      },
    })

    dap_virtual_text.setup({
        enabled = true,
        enabled_commands = true,
        highlight_changed_variables = true,
        highlight_new_as_changed = false,
        show_stop_reason = true,
        commented = false,
        only_first_definition = true,
        all_references = false,
        clear_on_continue = false,
        display_callback = function(variable, _, _, _, options)
          if options.virt_text_pos == 'inline' then
            return ' = ' .. variable.value:gsub("%s+", " ")
          else
            return variable.name .. ' = ' .. variable.value:gsub("%s+", " ")
          end
        end,
        virt_text_pos = vim.fn.has 'nvim-0.10' == 1 and 'inline' or 'eol',
        all_frames = false,
        virt_lines = false,
        virt_text_win_col = nil,
    })

    dap.listeners.before.attach.dapui_config = function() dapui.open() end
    dap.listeners.before.launch.dapui_config = function() dapui.open() end
    dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
    dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

    -- Suppress debugpySockets warnings
    dap.listeners.before.event_debugpySockets.dapui_config = function() end

    -- Custom signs for nvim-dap
    vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#993939', bg = '#31353f' })
    vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = '#61afef', bg = '#31353f' })
    vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#98c379', bg = '#31353f' })

    vim.fn.sign_define('DapBreakpoint', {text='●', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint'})
    vim.fn.sign_define('DapStopped', {text='', texthl='DapStopped', linehl='DapStopped', numhl='DapStopped'})
    vim.fn.sign_define('DapBreakpointRejected', {text='❌', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint'})
    vim.fn.sign_define('DapLogPoint', {text='X', texthl='DapLogPoint', linehl='DapLogPoint', numhl='DapLogPoint'})

    -- DAP keymaps
    vim.keymap.set("n", "<F5>", dap.continue, { desc = "DAP: continue"})
    vim.keymap.set("n", "<F6>", dap.terminate, { desc = "DAP: terminate"})
    vim.keymap.set("n", "<F9>", dap.toggle_breakpoint, { desc = "DAP: toggle breakpoint"})
    vim.keymap.set("n", "<F10>", dap.step_over, { desc = "DAP: step over"})
    vim.keymap.set("n", "<F11>", dap.step_into, { desc = "DAP: step into"})
    vim.keymap.set("n", "<F12>", dap.step_out, { desc = "DAP: step out"})

    -- Debugger adapters
    dap.adapters.gdb = {
      type = "executable",
      command = "gdb",
      args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
    }

    dap.adapters.python = function(callback, _)
      local python_path = vim.env.VIRTUAL_ENV and (vim.env.VIRTUAL_ENV .. '/bin/python3') or 'python3'
      callback({
        type = 'executable',
        command = python_path,
        args = { '-m', 'debugpy.adapter' },
      })
    end

    -- Determine Python path once at config time
    local python_path = vim.env.VIRTUAL_ENV and (vim.env.VIRTUAL_ENV .. '/bin/python3') or 'python3'

    dap.configurations.python = {
      {
        name = "Pytest: Current File",
        type = "python",
        request = "launch",
        module = "pytest",
        args = function()
          return {
            vim.fn.expand('%:p'),
            "-sv",
            "--log-cli-level=INFO",
            "--log-file=test_out.log"
          }
        end,
        console = "integratedTerminal",
        justMyCode = false,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        pythonPath = python_path,
        env = function()
          local env = {}
          if vim.env.PYTHONPATH then
            env.PYTHONPATH = vim.env.PYTHONPATH
          end
          if vim.env.VIRTUAL_ENV then
            env.VIRTUAL_ENV = vim.env.VIRTUAL_ENV
          end
          return env
        end,
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

    -- Auto-load project-specific DAP configurations from VSCode launch.json
    vim.defer_fn(function()
      local paths = {
        vim.fn.getcwd() .. '/.vscode/launch.json',
        vim.fn.getcwd() .. '/.vscode_shared/launch.json',
      }

      for _, path in ipairs(paths) do
        if vim.fn.filereadable(path) == 1 then
          local ok, _ = pcall(require('dap.ext.vscode').load_launchjson, path)
          if ok then
            vim.notify("Loaded DAP configurations from " .. vim.fn.fnamemodify(path, ':~:.'), vim.log.levels.INFO)
          end
          return
        end
      end
    end, 100)
  end
}
