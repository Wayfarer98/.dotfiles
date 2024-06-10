return {
    {
        "rcarriga/nvim-dap-ui",
        enabled = function()
            return vim.g.vscode == nil
        end,
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    },
    {
        "theHamsta/nvim-dap-virtual-text",
        enabled = function()
            return vim.g.vscode == nil
        end,
    },
    {
        "mfussenegger/nvim-dap-python",
        enabled = function()
            return vim.g.vscode == nil
        end,
        config = function()
            require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")
        end
    }
}
