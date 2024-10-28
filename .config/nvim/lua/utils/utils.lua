local M = {}

-- Lets the user select the startup project for fsharp or csharp debugging.
-- The function will find the corresponding dll of the project
M.find_dll_for_selected_project = function()
  local build_done = false
  vim.notify('Building solution...', vim.log.levels.INFO)
  vim.fn.jobstart('dotnet build -c Debug', {
    cwd = vim.fn.getcwd(),
    on_exit = function()
      build_done = true
      vim.notify('Build done...', vim.log.levels.INFO)
    end,
  })

  local result = {}
  local job_done = false
  vim.fn.jobstart('dotnet sln list', {
    cwd = vim.fn.getcwd(),
    stdout_buffered = true,
    on_stdout = function(_, data)
      for _, line in ipairs(data) do
        if line and line:match '%.csproj$' or line:match '%.fsproj$' then
          table.insert(result, line)
        end
      end
      job_done = true
    end,
  })
  while not job_done do
    vim.wait(100)
  end
  if #result == 0 then
    return nil
  end

  local co = coroutine.running()
  local selected_project = ''
  vim.ui.select(result, {
    prompt = 'Select startup project: ',
  }, function(choice)
    selected_project = choice
    coroutine.resume(co)
  end)
  coroutine.yield()

  while not build_done do
    vim.wait(100)
  end

  local dll_path = nil
  local project_dir = vim.fn.getcwd()
    .. '/'
    .. vim.fn.fnamemodify(selected_project, ':h')
  local framework_dir = nil
  local bin_debug_dir = project_dir .. '/bin/Debug/'
  for _, dir in ipairs(vim.fn.readdir(bin_debug_dir)) do
    if dir:match '^net%d+%.%d+$' then
      framework_dir = dir
      break
    end
  end

  if framework_dir then
    dll_path = string.format(
      '%s/bin/Debug/%s/%s.dll',
      project_dir,
      framework_dir,
      vim.fn.fnamemodify(selected_project, ':t:r')
    )
  else
    dll_path = vim.fn.input('Path to dll: ', bin_debug_dir, 'file')
  end
  return dll_path
end

return M
