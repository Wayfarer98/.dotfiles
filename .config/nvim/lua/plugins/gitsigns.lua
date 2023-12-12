local M = {
    'lewis6991/gitsigns.nvim',
    enabled = function()
        return vim.g.vscode == nil
    end,
    event = { 'BufRead', 'BufNewFile' },
    config = true,
}

return M
