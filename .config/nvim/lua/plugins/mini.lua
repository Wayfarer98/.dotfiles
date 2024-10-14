local M = { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup { n_lines = 500 }

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - yaiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - yd'   - [S]urround [D]elete [']quotes
    -- - yr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup {
      mappings = {
        add = 'yn',
        delete = 'yd',
        replace = 'yr',
        find = 'yf',
        find_left = 'yF',
        highlight = 'yh',
        update_n_lines = 'yl',
      },
    }
  end,
}
return M
