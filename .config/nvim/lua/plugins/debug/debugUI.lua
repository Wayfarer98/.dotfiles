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
  local C = require('catppuccin.palettes').get_palette 'mocha'

  ---@diagnostic disable-next-line: missing-fields
  dapui.setup {
    icons = { expanded = '', collapsed = '', current_frame = '' },
  }

  sign('DapBreakpoint', {
    text = '●',
    texthl = 'DapBreakpoint',
    linehl = '',
    numhl = '',
    priority = 11,
  })
  sign('DapBreakpointCondition', {
    text = '●',
    texthl = 'DapBreakpointCondition',
    linehl = '',
    numhl = '',
    priority = 11,
  })
  sign('DapLogPoint', {
    text = '◆',
    texthl = 'DapLogPoint',
    linehl = '',
    numhl = '',
    priority = 11,
  })
  -- Remove the sign and highlight the line instead
  vim.api.nvim_set_hl(
    0,
    'DapStoppedLine',
    { default = true, bg = 'NvimDarkYellow' }
  )
  vim.api.nvim_set_hl(0, 'DapStoppedText', { default = true, bg = C.peach })
  sign('DapStopped', {
    text = '',
    texthl = 'DapStoppedText',
    linehl = 'DapStoppedLine',
    numhl = '',
  })
end

return M
