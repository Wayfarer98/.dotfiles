local M = {
  'folke/noice.nvim',
  lazy = false,
  enabled = true,
  opts = {
    lsp = {
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
      },
      hover = {
        enabled = false,
      },
      signature = {
        enabled = false,
      },
    },
    presets = {
      bottom_search = true,
      long_message_to_split = true,
      lsp_doc_border = true,
    },
    cmdline = {
      view = 'cmdline',
    },
  },
  dependencies = {
    { 'MunifTanjim/nui.nvim' },
  },
}

return M
