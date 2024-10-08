local M = { -- Adds git related signs to the gutter, as well as utilities for managing changes
  'lewis6991/gitsigns.nvim',
  event = { 'BufRead', 'BufNewFile' },
  opts = {
    signs = {
      add = { text = '│' },
      change = { text = '│' },
      delete = { text = '󰍵' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
      untracked = { text = '│' },
    },
  },
}
return M
