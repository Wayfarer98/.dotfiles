return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'nvim-telescope/telescope.nvim',
    -- plenary
    'nvim-lua/plenary.nvim',
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    -- 'leoluz/nvim-dap-go'
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
        '<leader>tb',
        dap.toggle_breakpoint,
        desc = 'Debug: [T]oggle [B]reakpoint',
      },
      {
        '<leader>B',
        function()
          dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        end,
        desc = 'Debug: Set [B]reakpoint',
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
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        -- 'delve',
        'netcoredbg',
        'python',
      },
    }

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    ---@diagnostic disable-next-line: missing-fields
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
    }

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Install golang specific config
    -- require('dap-go').setup {
    --   delve = {
    --     -- On Windows delve must be run attached or it crashes.
    --     -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
    --     detached = vim.fn.has 'win32' == 0,
    --   },
    -- }
    --

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
            '`connect.port` is required for a python `attack` configuration'
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
