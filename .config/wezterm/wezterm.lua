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
  -- Main workspace
  local mainTabs = {
    { title = 'Terminal', directory = os.getenv 'HOME' },
    { title = 'Code', directory = os.getenv 'HOME', command = 'nvim' },
  }
  local window = create_workspace('Main', mainTabs)

  -- PPD workspace
  local PPD_tabs = {
    {
      title = 'Terminal',
      directory = os.getenv 'HOME' .. '/Documents/Repos/Kandidat/PPD',
      command = 'source venv/bin/activate',
    },
    {
      title = 'Code',
      directory = os.getenv 'HOME' .. '/Documents/Repos/Kandidat/PPD',
      command = 'source venv/bin/activate\nnvim',
    },
  }
  create_workspace('PPD', PPD_tabs)

  -- TA workspace
  local TA_tabs = {
    {
      title = 'Terminal',
      directory = os.getenv 'HOME' .. '/Documents/Repos/TA',
    },
    {
      title = 'Code',
      directory = os.getenv 'HOME' .. '/Documents/Repos/TA',
      command = 'nvim',
    },
  }
  create_workspace('TA', mainTabs)

  -- Start out in the 'Main' workspace and maximize the window
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

-- setup neovim navigation and pane resizing integrations
local function is_vim(pane)
  local process_info = pane:get_foreground_process_info()
  local process_name = process_info and process_info.name

  return process_name == 'nvim' or process_name == 'vim'
end

local direction_keys = {
  Left = 'h',
  Down = 'j',
  Up = 'k',
  Right = 'l',
  -- reverse lookup
  h = 'Left',
  j = 'Down',
  k = 'Up',
  l = 'Right',
}

local function split_nav(resize_or_move, key)
  return {
    key = key,
    mods = resize_or_move == 'resize' and 'META' or 'CTRL',
    action = wezterm.action_callback(function(win, pane)
      if is_vim(pane) then
        -- pass the keys through to vim/nvim
        win:perform_action({
          SendKey = {
            key = key,
            mods = resize_or_move == 'resize' and 'META' or 'CTRL',
          },
        }, pane)
      else
        if resize_or_move == 'resize' then
          win:perform_action(
            { AdjustPaneSize = { direction_keys[key], 3 } },
            pane
          )
        else
          win:perform_action(
            { ActivatePaneDirection = direction_keys[key] },
            pane
          )
        end
      end
    end),
  }
end

local nav_keys = {}

-- set keybinds
config.keys = {
  -- Pane navigation and splitting
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
  -- move between split panes
  split_nav('move', 'h'),
  split_nav('move', 'j'),
  split_nav('move', 'k'),
  split_nav('move', 'l'),
  -- resize panes
  split_nav('resize', 'h'),
  split_nav('resize', 'j'),
  split_nav('resize', 'k'),
  split_nav('resize', 'l'),
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
end

return config
