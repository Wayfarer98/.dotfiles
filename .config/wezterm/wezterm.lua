local wezterm = require 'wezterm'
local act = wezterm.action
local mux = wezterm.mux
local config = wezterm.config_builder()

-- set the leader key
config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }

local function create_workspace(name, tabs)
  local _, base_pane, window = mux.spawn_window {
    workspace = name,
  }
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
  return window
end

wezterm.on('gui-startup', function()
  local mainTabs = {
    { title = 'Terminal', directory = os.getenv 'HOME' },
    { title = 'Code', directory = os.getenv 'HOME', command = 'nvim' },
  }
  local window = create_workspace('Main', mainTabs)
  create_workspace('AP', mainTabs)
  create_workspace('TA', mainTabs)
  mux.set_active_workspace 'Main'
  window:gui_window():maximize()
end)

-- set the colorscheme and appearance
config.color_scheme = 'Catppuccin Mocha'
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.window_background_opacity = 0.9
config.window_decorations = 'RESIZE'

-- set the font and font size
config.font = wezterm.font('JetBrains Mono', { weight = 'Regular' })
config.font_size = 14

-- set keybinds
config.keys = {
  -- Pane navigation and splitting
  { key = 'l', mods = 'CTRL', action = act.ActivatePaneDirection 'Right' },
  { key = 'h', mods = 'CTRL', action = act.ActivatePaneDirection 'Left' },
  { key = 'j', mods = 'CTRL', action = act.ActivatePaneDirection 'Down' },
  { key = 'k', mods = 'CTRL', action = act.ActivatePaneDirection 'Up' },
  {
    key = '\\',
    mods = 'LEADER',
    action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = '-',
    mods = 'LEADER',
    action = act.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'x',
    mods = 'LEADER',
    action = act.CloseCurrentPane { confirm = false },
  },
  -- Adjust pane size
  { key = 'l', mods = 'LEADER', action = act.AdjustPaneSize { 'Right', 5 } },
  { key = 'h', mods = 'LEADER', action = act.AdjustPaneSize { 'Left', 5 } },
  { key = 'j', mods = 'LEADER', action = act.AdjustPaneSize { 'Down', 5 } },
  { key = 'k', mods = 'LEADER', action = act.AdjustPaneSize { 'Up', 5 } },
  -- Tab keybinds
  {
    key = 'q',
    mods = 'LEADER',
    action = act.CloseCurrentTab { confirm = false },
  },
  { key = 'Tab', mods = 'LEADER', action = act.ActivateTabRelative(1) },
  { key = 'Tab', mods = 'LEADER|SHIFT', action = act.ActivateTabRelative(-1) },
  {
    key = 'c',
    mods = 'LEADER',
    action = act.SpawnTab 'CurrentPaneDomain',
  },
  -- Workspaces
  {
    key = 's',
    mods = 'LEADER',
    action = act.ShowLauncherArgs { flags = 'WORKSPACES' },
  },
  {
    key = 'n',
    mods = 'LEADER',
    action = act.PromptInputLine {
      description = wezterm.format {
        { Attribute = { Intensity = 'Bold' } },
        { Text = 'Name for new workspace: ' },
      },
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          window:perform_action(
            act.SwitchToWorkspace {
              name = line,
            },
            pane
          )
        end
      end),
    },
  },
  {
    key = ',',
    mods = 'LEADER',
    action = act.PromptInputLine {
      description = wezterm.format {
        { Attribute = { Intensity = 'Bold' } },
        { Text = 'Name for tab: ' },
      },
      action = wezterm.action_callback(function(window, _, line)
        if line then
          local tab = window:active_tab()
          tab:set_title(line)
        end
      end),
    },
  },
}

-- Use leader number to switch tabs, or F1-F9
for i = 1, 9 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = 'LEADER',
    action = act.ActivateTab(i - 1),
  })
  table.insert(config.keys, {
    key = 'F' .. tostring(i),
    action = act.ActivateTab(i - 1),
  })
end

return config
