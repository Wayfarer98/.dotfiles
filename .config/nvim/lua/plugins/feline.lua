local M = {
    'freddiehaddad/feline.nvim',
    enabled = function()
        return vim.g.vscode == nil
    end,
    lazy = false,
    config = function ()
        local ctp_feline = require('catppuccin.groups.integrations.feline')
        ctp_feline.setup({})

        require('feline').setup({
            components = ctp_feline.get()
        })
    end,
}

return M
