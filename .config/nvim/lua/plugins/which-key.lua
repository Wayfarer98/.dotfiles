local M = { -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  config = function() -- This is the function that runs, AFTER loading
    require('which-key').setup()

    -- Document existing key chains
    require('which-key').add {
      { '<leader>c', group = 'Code' },
      { '<leader>d', group = 'Document' },
      { '<leader>r', group = 'Rename' },
      { '<leader>s', group = 'Search' },
      { '<leader>w', group = 'Workspace' },
      { '<leader>t', group = 'Toggle' },
      { '<leader>x', group = 'Trouble' },
      { '<leader>a', group = 'AI' },
      { 'gm', group = '+Copilot chat' },
      { '<leader>h', group = 'Harpoon', mode = { 'n', 'v' } },
    }
  end,
}
return M
