local M = {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    menu = {
      width = vim.api.nvim_win_get_width(0) - 4,
    },
    settings = {
      save_on_toggle = true,
    },
  },
  keys = function()
    local keys = {
      {
        '<leader>ha',
        function()
          require('harpoon'):list():add()
        end,
        desc = 'Add the current buffer into the harpoon list',
      },
      {
        '<leader>ht',
        function()
          require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())
        end,
        desc = 'Toggle harpoon menu',
      },
      {
        '<Tab>',
        function()
          require('harpoon'):list():next { ui_nav_wrap = true }
        end,
        desc = 'Go to next buffer in harpoon list',
      },
      {
        '<S-Tab>',
        function()
          require('harpoon'):list():prev { ui_nav_wrap = true }
        end,
        desc = 'Go to previous buffer in harpoon list',
      },
    }
    for i = 1, 5 do
      table.insert(keys, {
        '<leader>' .. i,
        function()
          require('harpoon'):list():select(i)
        end,
        desc = 'Select buffer ' .. i .. ' in harpoon list',
      })
    end
    return keys
  end,
}
return M
