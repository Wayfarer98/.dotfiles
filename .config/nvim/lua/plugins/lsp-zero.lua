local M = {
    'VonHeikemen/lsp-zero.nvim',
    enabled = function()
        return vim.g.vscode == nil
    end,
    branch = 'v3.x',
    lazy = true,
    config = false,
    init = function ()
        vim.g.lsp_zero_extend_cmp = 0
        vim.g.lsp_zero_extend_lspconfig = 0
    end,
}

return M
