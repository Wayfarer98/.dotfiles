local M = {
    'stevearc/dressing.nvim',
    enabled = function()
        return vim.g.vscode == nil
    end,
    event = 'VeryLazy'
}

return M
