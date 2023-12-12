return {
    "tpope/vim-sleuth",
    enabled = function()
        return vim.g.vscode == nil
    end,
}
