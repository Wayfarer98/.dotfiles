local M = {
    'williamboman/mason.nvim',
    enabled = function()
        return vim.g.vscode == nil
    end,
    lazy = false,
}

return M
