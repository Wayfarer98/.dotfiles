return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
    {
      'jay-babu/mason-nvim-dap.nvim',
      dependencies = 'mason-org/mason.nvim',
      cmd = { 'DapInstall', 'DapUninstall' },
    },
    'mfussenegger/nvim-dap-python',
  },
  keys = require('plugins.debug.debugKeymaps').keys,
  config = function()
    local dap = require 'dap'
    local adapters = require 'plugins.debug.debugAdapters'
    local configs = require 'plugins.debug.debugConfigurations'
    local ui = require 'plugins.debug.debugUI'

    require('mason-nvim-dap').setup {
      automatic_installation = true,

      handlers = {},

      ensure_installed = adapters.ensure_installed,
    }

    -- Sets the listeners for the UI, e.g. open/close the UI when debugging is started/stopped
    ui.setup_listeners()
    -- Sets the icons for the UI, e.g. breakpoint icon
    ui.setup_icons()

    -- setup all adapters that are defined in debugAdapters.lua
    for name, adapter in pairs(adapters) do
      dap.adapters[name] = adapter
    end

    -- setup all configurations that are defined in debugConfigurations.lua
    for name, configuration in pairs(configs) do
      dap.configurations[name] = configuration
    end
  end,
}
