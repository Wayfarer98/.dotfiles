local M = {
  'alexghergh/nvim-tmux-navigation',
  lazy = false,
  enabled = false,
  opts = {
    disable_when_zoomed = true,
    keybindings = {
      left = '<C-h>',
      down = '<C-j>',
      up = '<C-k>',
      right = '<C-l>',
      last_active = '<C-\\>',
    },
  },
}
return M
