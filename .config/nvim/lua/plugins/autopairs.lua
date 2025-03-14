local M = {
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {
      fast_wrap = {
        map = '<C-e>',
        chars = { '{', '[', '(', '"', "'", '`' },
        cursor_pos_before = false,
      },
    },
  },

  {
    'windwp/nvim-ts-autotag',
    config = function()
      require('nvim-ts-autotag').setup()
    end,
  },
}

return M
