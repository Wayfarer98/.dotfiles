local M = {
  'folke/trouble.nvim',
  cmd = 'Trouble',
  opts = {
    preview = {
      type = 'float',
      relative = 'editor',
      border = 'rounded',
      title = 'Preview',
      title_pos = 'center',
      position = { 0, 0 },
      size = { width = 0.4, height = 0.4 },
      zindex = 200,
    },
  },
  keys = {
    {
      '<leader>x',
      desc = 'Trouble',
      mode = { 'n', 'v' },
    },
    {
      '<leader>xx',
      '<cmd>Trouble diagnostics toggle<cr>',
      desc = 'Diagnostics (Trouble) toggle',
    },
    {
      '<leader>xX',
      '<cmd>Trouble diagnostics toggle focus=true filter.buf=0<cr>',
      desc = 'Buffer Diagnostics (Trouble) toggle',
    },
    {
      '<leader>xs',
      '<cmd>Trouble symbols toggle focus=true<cr>',
      desc = 'Symbols (Trouble) toggle',
    },
    {
      '<leader>xd',
      '<cmd>Trouble lsp toggle focus=true win.position=right<cr>',
      desc = 'LSP Definitions / references / ... (Trouble) toggle',
    },
    {
      '<leader>xl',
      '<cmd>Trouble loclist toggle focus=true<cr>',
      desc = 'Location List (Trouble) toggle',
    },
    {
      '<leader>xq',
      '<cmd>Trouble qflist toggle focus=true<cr>',
      desc = 'Quickfix List (Trouble) toggle',
    },
    {
      '<leader>xt',
      '<cmd>Trouble telescope toggle focus=true<cr>',
      desc = 'Telescope (Trouble) toggle',
    },
  },
}
return M
