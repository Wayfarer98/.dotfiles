-- padding for the notify window row
local pad = vim.o.cmdheight + (vim.o.laststatus > 0 and 1 or 0) + 1
local hipatterns = require 'mini.hipatterns'

local M = {
  files = {
    mappings = {
      go_in_plus = '<CR>',
    },
  },
  indenscope = {
    options = { try_as_border = true },
  },
  hipatterns = {
    highlighters = {
      -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
      fixme = {
        pattern = '%f[%w]()FIXME()%f[%W]',
        group = 'MiniHipatternsFixme',
      },
      hack = {
        pattern = '%f[%w]()HACK()%f[%W]',
        group = 'MiniHipatternsHack',
      },
      todo = {
        pattern = '%f[%w]()TODO()%f[%W]',
        group = 'MiniHipatternsTodo',
      },
      note = {
        pattern = '%f[%w]()NOTE()%f[%W]',
        group = 'MiniHipatternsNote',
      },

      -- Highlight hex color strings (`#rrggbb`) using that color
      hex_color = hipatterns.gen_highlighter.hex_color(),
    },
  },
  diff = {
    view = {
      style = 'sign',
      priority = 9,
    },
  },
}
return M
