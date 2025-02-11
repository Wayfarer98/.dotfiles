local M = {
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = false,
  priority = 1000,
  opts = {
    flavour = 'mocha',
    integrations = {
      cmp = true,
      gitsigns = true,
      treesitter = true,
      mason = true,
      fidget = true,
      lsp_trouble = true,
      harpoon = true,
      dap = true,
      dap_ui = true,
      which_key = true,
      telescope = {
        enabled = true,
      },
      mini = {
        enabled = true,
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
