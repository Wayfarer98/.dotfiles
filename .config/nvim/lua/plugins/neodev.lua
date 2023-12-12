local M = {
    {
        "folke/neodev.nvim",
        enabled = function()
            return vim.g.vscode == nil
        end,
        opts = {
            library = {
                plugins = { "neotest", "nvim-dap-ui" },
                types = true,
            },
        }
    }
}

return M
