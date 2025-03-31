-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/dap/core.lua
---@param config {type?:string, args?:string[]|fun():string[]?}
local function get_args(config)
  local args = type(config.args) == 'function' and (config.args() or {})
    or config.args
    or {} --[[@as string[] | string ]]
  local args_str = type(args) == 'table' and table.concat(args, ' ') or args --[[@as string]]

  config = vim.deepcopy(config)
  ---@cast args string[]
  config.args = function()
    local new_args = vim.fn.expand(vim.fn.input('Run with args: ', args_str)) --[[@as string]]
    if config.type and config.type == 'java' then
      ---@diagnostic disable-next-line: return-type-mismatch
      return new_args
    end
    return require('dap.utils').splitstr(new_args)
  end
  return config
end

local M = {}

M.keys = function()
  local dap = require 'dap'
  local dapui = require 'dapui'
  return {
    {
      '<leader>dB',
      function()
        dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end,
      desc = 'Set breakpoint conditionally',
    },
    {
      '<leader>db',
      dap.toggle_breakpoint,
      desc = 'Toggle breakpoint',
    },
    {
      '<leader>dc',
      dap.continue,
      desc = 'Run/Continue',
    },
    {
      '<leader>da',
      function()
        dap.continue { before = get_args }
      end,
      desc = 'Run with arguments',
    },
    {
      '<leader>dC',
      dap.run_to_cursor,
      desc = 'Run to cursor',
    },
    {
      '<leader>dg',
      dap.goto_,
      desc = 'Go to line (No execute)',
    },
    {
      '<leader>di',
      dap.step_into,
      desc = 'Step into',
    },
    {
      '<leader>dj',
      dap.down,
      desc = 'Down',
    },
    {
      '<leader>dk',
      dap.up,
      desc = 'Up',
    },
    {
      '<leader>dl',
      dap.run_last,
      desc = 'Run last',
    },
    {
      '<leader>do',
      dap.step_out,
      desc = 'Step out',
    },
    {
      '<leader>dO',
      dap.step_over,
      desc = 'Step over',
    },
    {
      '<leader>dP',
      dap.pause,
      desc = 'Pause',
    },
    {
      '<leader>dr',
      dap.repl.toggle,
      desc = 'Toggle REPL',
    },
    {
      '<leader>ds',
      dap.session,
      desc = 'Session',
    },
    {
      '<leader>dt',
      dap.terminate,
      desc = 'Terminate',
    },
    {
      '<leader>dw',
      require('dap.ui.widgets').hover,
      desc = 'Widgets',
    },
    {
      '<leader>du',
      function()
        dapui.toggle {}
      end,
      desc = 'Toggle UI',
    },
    {
      '<leader>de',
      dapui.eval,
      mode = { 'n', 'v' },
      desc = 'Eval',
    },
    { '<F5>', dap.continue, desc = 'Debug: Start/Continue' },
    { '<F1>', dap.step_over, desc = 'Debug: Step Over' },
    { '<F3>', dap.step_into, desc = 'Debug: Step Into' },
    { '<F4>', dap.step_out, desc = 'Debug: Step Out' },
  }
end

return M
