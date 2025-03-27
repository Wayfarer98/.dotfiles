local M = {}

M.setup_listeners = function()
  local dap = require 'dap'
  local dapui = require 'dapui'

  dap.listeners.after.event_initialized['dapui_config'] = dapui.open
  dap.listeners.before.event_terminated['dapui_config'] = dapui.close
  dap.listeners.before.event_exited['dapui_config'] = dapui.close
end

M.setup_icons = function()
  local dapui = require 'dapui'
  local sign = vim.fn.sign_define

  ---@diagnostic disable-next-line: missing-fields
  dapui.setup {
    icons = { expanded = '', collapsed = '', current_frame = '' },
  }

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
  -- Remove the sign and highlight the line instead
  vim.api.nvim_set_hl(0, 'DapStoppedLine', { default = true, link = 'Visual' })
  sign('DapStopped', { text = '', linehl = 'DapStoppedLine', numhl = '' })
end

return M
