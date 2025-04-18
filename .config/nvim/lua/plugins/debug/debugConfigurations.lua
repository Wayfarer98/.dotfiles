local utils = require 'utils.utils'

local M = {}

M.python = {
  {
    type = 'python',
    request = 'launch',
    name = 'Launch file',
    program = '${file}',
    pythonPath = function()
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

M.fsharp = {
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

M.cpp = {
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
    cwd = vim.fn.getcwd(),
    stopOnEntry = false,
    args = {},
    runInTerminal = true,
  },
  {
    name = 'duckdb fh',
    type = 'cppdbg',
    request = 'launch',
    program = function()
      return vim.fn.getcwd() .. '/build/reldebug/duckdb'
    end,
    cwd = vim.fn.getcwd(),
    stopOnEntry = false,
    args = { '/mnt/LinuxData/Speciale/test.db' },
    runInTerminal = true,
  },
  {
    name = 'duckdb xnvme sync',
    type = 'cppdbg',
    request = 'launch',
    program = function()
      return vim.fn.getcwd() .. '/build/reldebug/duckdb'
    end,
    cwd = vim.fn.getcwd(),
    stopOnEntry = false,
    args = { '-xsync', '/mnt/LinuxData/Speciale/test.db' },
    runInTerminal = true,
  },
  {
    name = 'duckdb xnvme async',
    type = 'cppdbg',
    request = 'launch',
    program = function()
      return vim.fn.getcwd() .. '/build/reldebug/duckdb'
    end,
    cwd = vim.fn.getcwd(),
    stopOnEntry = false,
    args = { '-xasync', '/mnt/LinuxData/Speciale/test.db' },
    runInTerminal = true,
  },
}
return M
