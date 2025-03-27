local M = {}

-- Ensure installed
M.ensure_installed = {
  'netcoredbg',
  'python',
  'cpptools',
}

-- Adapter for Python debugging
M.python = {
  type = 'executable',
  command = os.getenv 'HOME'
    .. '/.local/share/nvim/mason/packages/debugpy/venv/bin/python',
  args = { '-m', 'debugpy.adapter' },
  options = {
    source_filetype = 'python',
  },
}

-- Adapter for C++ debugging
M.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = os.getenv 'HOME' .. '/.local/share/nvim/mason/bin/OpenDebugAD7',
}

-- Adapter for .NET Core debugging
M.coreclr = {
  type = 'executable',
  command = os.getenv 'HOME' .. '/.local/share/nvim/mason/bin/netcoredbg',
  args = { '--interpreter=vscode' },
}

return M
