local wezterm = require 'wezterm'
local mux = wezterm.mux
local function create_workspaces(workspaces)
  local retWindow = nil
  for name, tabs in pairs(workspaces) do
    local _, base_pane, window = mux.spawn_window {
      workspace = name,
    }
    if not retWindow and name == 'Main' then
      retWindow = window
    end
    base_pane:send_text 'exit\n'
    local base_tab = window:active_tab()
    for i, tab in ipairs(tabs) do
      local muxTab, muxPane, _ = window:spawn_tab {
        cwd = tab.directory,
      }
      if i == 0 then
        base_tab = muxTab
      end
      muxTab:set_title(tab.title)
      if tab.command then
        muxPane:send_text(tab.command .. '\n')
      end
    end
    base_tab:activate()
  end
  return retWindow
end
local workspaces = {
  Main = {
    { title = 'Terminal', directory = os.getenv 'HOME' },
    { title = 'Code', directory = os.getenv 'HOME', command = 'nvim' },
  },
  Speciale = {
    {
      title = 'Terminal',
      directory = os.getenv 'HOME' .. '/Documents/Repos/Kandidat/Speciale',
    },
    {
      title = 'Code',
      directory = os.getenv 'HOME' .. '/Documents/Repos/Kandidat/Speciale',
      command = 'nvim',
    },
  },
  DPP = {
    {
      title = 'Terminal',
      directory = os.getenv 'HOME' .. '/Documents/Repos/Kandidat/DPP',
    },
    {
      title = 'SSH',
      directory = os.getenv 'HOME' .. '/Documents/Repos/Kandidat/DPP',
    },
    {
      title = 'Code',
      directory = os.getenv 'HOME' .. '/Documents/Repos/Kandidat/DPP',
      command = 'nvim',
    },
  },
  TA = {
    {
      title = 'Terminal',
      directory = os.getenv 'HOME' .. '/Documents/Repos/TA',
      command = 'source staffeli_nt/env/bin/activate\nclear',
    },
    {
      title = 'Code',
      directory = os.getenv 'HOME' .. '/Documents/Repos/TA',
      command = 'source staffeli_nt/env/bin/activate\nclear\nnvim',
    },
  },
  AOC = {
    {
      title = 'Terminal',
      directory = os.getenv 'HOME' .. '/Documents/Repos/AdventOfCode/2024',
      command = 'source venv/bin/activate\nclear',
    },
    {
      title = 'Code',
      directory = os.getenv 'HOME' .. '/Documents/Repos/AdventOfCode/2024',
      command = 'source venv/bin/activate\nclear\nnvim',
    },
  },
  CS = {
    {
      title = 'Terminal',
      directory = os.getenv 'HOME'
        .. '/Documents/Repos/Roadmap/CS/DataStructures',
    },
    {
      title = 'Code',
      directory = os.getenv 'HOME'
        .. '/Documents/Repos/Roadmap/CS/DataStructures',
      command = 'nvim',
    },
  },
}
local workspaceModule = {}
function workspaceModule.initializeWorkspaces()
  return create_workspaces(workspaces)
end
return workspaceModule
