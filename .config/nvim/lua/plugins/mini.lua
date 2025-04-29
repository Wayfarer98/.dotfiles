local M = { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  config = function()
    local opts = require 'config.mini-opts'
    -- Text editing
    require('mini.icons').setup()
    require('mini.ai').setup { n_lines = 500 }
    require('mini.comment').setup()
    require('mini.move').setup()
    require('mini.splitjoin').setup()
    require('mini.surround').setup()

    -- General workflow
    require('mini.files').setup(opts.files)
    require('mini.git').setup()

    -- Appearance
    require('mini.indentscope').setup(opts.indentscope)
    require('mini.hipatterns').setup(opts.hipatterns)
    require('mini.starter').setup()
    require('mini.diff').setup(opts.diff)
  end,
  keys = function()
    local files = require 'mini.files'
    return {
      {
        '\\',
        function()
          if files.get_explorer_state() then
            files.close()
          else
            if vim.fn.expand '%' == 'ministarter://1/welcome' then
              files.open(nil, false)
            else
              files.open(vim.api.nvim_buf_get_name(0), false)
            end
          end
        end,
        desc = 'open mini file explorer',
      },
      {
        '|',
        function()
          if files.get_explorer_state() then
            files.close()
          else
            files.open(nil, false)
          end
        end,
        desc = 'open mini file explorer',
      },
    }
  end,
}
return M
