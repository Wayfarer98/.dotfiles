if vim.g.vscode == nil then
    return {
        { "mfussenegger/nvim-dap" },
        {
            "rcarriga/nvim-dap-ui",
            dependencies = { "mfussenegger/nvim-dap" },
            opts = {}
        },
        { "theHamsta/nvim-dap-virtual-text" },
        {
            "mfussenegger/nvim-dap-python",
            config = function()
                require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")
            end
        }
    }
else
end
