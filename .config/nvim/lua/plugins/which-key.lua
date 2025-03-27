local M = { -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  config = function() -- This is the function that runs, AFTER loading
    require('which-key').setup()

    -- Document existing key chains
    require('which-key').add {
      { '<leader>c', group = 'Code' },
      { '<leader>d', group = 'Debug' },
      { '<leader>r', group = 'Rename' },
      { '<leader>s', group = 'Search' },
      { '<leader>f', group = 'Find' },
      { '<leader>g', group = 'Git' },
      { '<leader>l', group = 'Lazygit' },
      { '<leader>w', group = 'Workspace' },
      { '<leader>t', group = 'Toggle' },
      { '<leader>x', group = 'Trouble' },
      { '<leader>b', group = 'Breakpoints' },
      { '<leader>a', group = 'AI' },
      { '<leader>h', group = 'Harpoon', mode = { 'n', 'v' } },
    }
  end,
}
return M
