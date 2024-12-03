local M = {
  'echasnovski/mini.indentscope',
  version = false,
  event = 'BufEnter',
  opts = {
    symbol = '|',
    options = { try_as_border = true },
  },
  init = function()
    vim.api.nvim_create_autocmd('FileType', {
      pattern = {
        'Trouble',
        'alpha',
        'dashboard',
        'fzf',
        'help',
        'lazy',
        'mason',
        'neo-tree',
        'nvim-tree',
        'notify',
        'snacks_dashboard',
        'snacks_notif',
        'snacks_terminal',
        'snacks_win',
        'toggleterm',
        'trouble',
      },
      callback = function()
        vim.b.miniindentscope_disable = true
      end,
    })
  end,
}
return M
