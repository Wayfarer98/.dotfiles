local M = {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'

    harpoon:setup()
    --
    -- Keybindings
    vim.keymap.set('n', '<leader>ha', function()
      harpoon:list():add()
    end, { desc = '[H]arpoon [A]dd the current buffer into the harpoon list' })
    vim.keymap.set('n', '<leader>ht', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = '[H]arpoon [T]oggle menu' })

    vim.keymap.set('n', '<c-1>', function()
      harpoon:list():select(1)
    end, { desc = 'Select buffer 1 in harpoon list' })
    vim.keymap.set('n', '<c-2>', function()
      harpoon:list():select(2)
    end, { desc = 'Select buffer 2 in harpoon list' })
    vim.keymap.set('n', '<c-3>', function()
      harpoon:list():select(3)
    end, { desc = 'Select buffer 3 in harpoon list' })
    vim.keymap.set('n', '<c-4>', function()
      harpoon:list():select(4)
    end, { desc = 'Select buffer 4 in harpoon list' })
    vim.keymap.set('n', '<c-5>', function()
      harpoon:list():select(5)
    end, { desc = 'Select buffer 5 in harpoon list' })

    vim.keymap.set('n', '<tab>', function()
      harpoon:list():next()
    end, { desc = 'Select next buffer in harpoon list' })

    vim.keymap.set('n', '<S-tab>', function()
      harpoon:list():next()
    end, { desc = 'Select previous buffer in harpoon list' })
  end,
}
return M
