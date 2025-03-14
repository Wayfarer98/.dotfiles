local M = {
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = false,
  priority = 1000,
  opts = {
    flavour = 'mocha',
    integrations = {
      blink_cmp = true,
      cmp = true,
      dap = true,
      dap_ui = true,
      fidget = true,
      fzf = true,
      gitsigns = true,
      harpoon = true,
      lsp_trouble = true,
      markdown = true,
      mason = true,
      treesitter = true,
      which_key = true,
      mini = {
        enabled = true,
        indentscope_color = 'lavender',
      },
      noice = true,
    },
    transparent_background = true,
  },
  config = function(_, opts)
    require('catppuccin').setup(opts)
    vim.cmd.colorscheme 'catppuccin'
  end,
}

return M
