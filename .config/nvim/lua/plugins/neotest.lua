local M = {
    "nvim-neotest/neotest",
    enabled = function()
        return vim.g.vscode == nil
    end,
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-neotest/neotest-python",
        "nvim-neotest/neotest-jest"
    },
    config = function()
        require("neotest").setup({
            adapters = {
                require("neotest-python")({
                    runner = "pytest",
                }),
                require("neotest-jest")({
                    jestCommand = "npm test --",
                    jestConfigFile = "jest.config.ts",
                    env = { CI = true },
                    cwd = function()
                        return vim.fn.getcwd()
                    end,
                })
            }
        })
    end
}

return M
