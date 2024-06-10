local M = {
    'lukas-reineke/indent-blankline.nvim',
    enabled = function()
        return vim.g.vscode == nil
    end,
    event = 'BufReadPre',
    main = "ibl",
}

return M
