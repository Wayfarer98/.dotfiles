return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    'mfussenegger/nvim-dap-python',
  },
  keys = function(_, keys)
    local dap = require 'dap'
    local dapui = require 'dapui'
    return {
      -- Basic debugging keymaps, feel free to change to your liking!
      { '<F5>', dap.continue, desc = 'Debug: Start/Continue' },
      { '<F1>', dap.step_over, desc = 'Debug: Step Over' },
      { '<F3>', dap.step_into, desc = 'Debug: Step Into' },
      { '<F4>', dap.step_out, desc = 'Debug: Step Out' },
      {
        '<leader>bt',
        dap.toggle_breakpoint,
        desc = 'Debug: [T]oggle [B]reakpoint',
      },
      {
        '<leader>bc',
        function()
          dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        end,
        desc = 'Debug: Set breakpoint conditionally',
      },
      -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
      { '<F7>', dapui.toggle, desc = 'Debug: See last session result.' },
      unpack(keys),
    }
  end,
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'
    local utils = require 'utils.utils'

    require('mason-nvim-dap').setup {
      automatic_installation = false,

      handlers = {},

      ensure_installed = {
        'netcoredbg',
        'python',
        'cpptools',
      },
    }

    -- For more information, see |:help nvim-dap-ui|
    ---@diagnostic disable-next-line: missing-fields
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      icons = { expanded = '', collapsed = '', current_frame = '' },
    }

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Debud adapter for .NET Core
    dap.adapters.coreclr = {
      type = 'executable',
      command = os.getenv 'HOME' .. '/.local/share/nvim/mason/bin/netcoredbg',
      args = { '--interpreter=vscode' },
    }

    dap.adapters.python = function(cb, config)
      if config.request == 'attach' then
        local port = (config.connect or config).port
        local host = (config.connect or config).host or '127.0.0.1'

        cb {
          type = 'server',
          port = assert(
            port,
            '`connect.port` is required for a python `attach` configuration'
          ),
          host = host,
          options = {
            source_filetype = 'python',
          },
        }
      else
        cb {
          type = 'executable',
          command = os.getenv 'HOME'
            .. '/.local/share/nvim/mason/packages/debugpy/venv/bin/python',
          args = { '-m', 'debugpy.adapter' },
          options = {
            source_filetype = 'python',
          },
        }
      end
    end

    dap.adapters.cppdbg = {
      id = 'cppdbg',
      type = 'executable',
      command = os.getenv 'HOME' .. '/.local/share/nvim/mason/bin/OpenDebugAD7',
    }

    -- Debug configuration for F#
    dap.configurations.fsharp = {
      {
        type = 'coreclr',
        name = 'Launch - netcoredbg',
        request = 'launch',
        cwd = vim.fn.getcwd(),
        program = function()
          return utils.find_dll_for_selected_project()
        end,
        args = {},
        env = {},
      },
    }

    -- Debug configuration for Python
    dap.configurations.python = {
      {
        -- The first three options are required by nvim-dap
        type = 'python', -- the type here established the link to the adapter definition: `dap.adapters.python`
        request = 'launch',
        name = 'Launch file',

        -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

        program = '${file}', -- This configuration will launch the current file if used.
        pythonPath = function()
          -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
          -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
          -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
          local cwd = vim.fn.getcwd()
          if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
            return cwd .. '/venv/bin/python'
          elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
            return cwd .. '/.venv/bin/python'
          else
            return vim.fn.exepath 'python'
          end
        end,
      },
    }

    dap.configurations.cpp = {
      {
        name = 'Launch file',
        type = 'cppdbg',
        request = 'launch',
        program = function()
          return vim.fn.input(
            'Path to executable: ',
            vim.fn.getcwd() .. '/',
            'file'
          )
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
        runInTerminal = true,
      },
    }

    local sign = vim.fn.sign_define

    sign(
      'DapBreakpoint',
      { text = '●', texthl = 'DapBreakpoint', linehl = '', numhl = '' }
    )
    sign('DapBreakpointCondition', {
      text = '●',
      texthl = 'DapBreakpointCondition',
      linehl = '',
      numhl = '',
    })
    sign(
      'DapLogPoint',
      { text = '◆', texthl = 'DapLogPoint', linehl = '', numhl = '' }
    )
  end,
}
