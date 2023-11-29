local M = {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-neotest/neotest-python"
    },
    opts = {
        adapters = {
            require("neotest-python").setup({
                args = { "--log-level", "DEBUG" },
                runner = "pytest",
            }),
        }
    },
}

return M
