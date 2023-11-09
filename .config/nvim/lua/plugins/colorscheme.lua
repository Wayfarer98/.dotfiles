local M = {
	"catppuccin/nvim",
    name = "catppuccin",
	lazy = false,
	priority = 1000,
    opts = {
        flavour = 'mocha',
        integrations = {
            cmp = true,
            treesitter = true,
            harpoon = true,
            leap = true,
            mason = true,
            telescope = {
                enabled = true
            }
        },
        transparent_background = true
    },
    config = function (_, opts)
        require('catppuccin').setup(opts)
        vim.cmd.colorscheme('catppuccin')
    end
}

return M
