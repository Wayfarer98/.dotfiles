local M = {
    "nvim-telescope/telescope-file-browser.nvim",
    enabled = function()
        return vim.g.vscode == nil
    end,
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    opts = {
        extensions = {
            file_browser = {
                hijack_netrw = true,
            }
        }
    },
    config = function(_, opts)
        local telescope = require('telescope')
        telescope.setup(opts)
        telescope.load_extension('file_browser')
    end
}
return M
