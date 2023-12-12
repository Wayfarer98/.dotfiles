local M = {
    "zbirenbaum/copilot.lua",
    enabled = function()
        return vim.g.vscode == nil
    end,
    cmd = "Copilot",
    build = ":Copilot auth",
    evens = 'InsertEnter',
    opts = {
        suggestion = { enabled = true, auto_trigger = true, accept = false },
        panel = { enabled = true, auto_refresh = true },
    },

    config = function(_, opts)
        require("copilot").setup(opts)
        local cmp_status_ok, cmp = pcall(require, "cmp")
        if cmp_status_ok then
            cmp.event:on("menu_opened", function()
                vim.b.copilot_suggestion_hidden = true
            end)

            cmp.event:on("menu_closed", function()
                vim.b.copilot_suggestion_hidden = false
            end)
        end
    end
}

return M
