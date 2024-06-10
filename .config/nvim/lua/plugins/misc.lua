return {
    { "nvim-lua/plenary.nvim", 
        enabled = function()
            return vim.g.vscode == nil
        end,
    },

    { "nvim-tree/nvim-web-devicons",
        enabled = function()
            return vim.g.vscode == nil
        end,
        opts = { default = true }
    },
}