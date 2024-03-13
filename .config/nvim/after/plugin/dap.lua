if not vim.g.vscode then
    local dap = require("dap")
    local dapui = require("dapui")

    -- Keybinds
    vim.keymap.set("n", "<leader>dt", function() dapui.toggle() end, { desc = "Toggle debugging UI" })
    vim.keymap.set("n", "<leader>db", function() dap.toggle_breakpoint() end, { desc = "Toggle breakpoint" })
    vim.keymap.set("n", "<leader>dC", function() dap.clear_breakpoints() end, { desc = "Clear all breakpoints" })
    vim.keymap.set("n", "<leader>dc", function() dap.continue() end, { desc = "Continue through debugging code" })
    vim.keymap.set("n", "<leader>dr", function() dapui.open({ reset = true }) end, { desc = "Reset UI and open" })
    vim.keymap.set("n", "<leader>do", function() dap.step_over() end, { desc = "Debugger step over" })
    vim.keymap.set("n", "<leader>dO", function() dap.step_out() end, { desc = "Debugger step out" })
    vim.keymap.set("n", "<leader>di", function() dap.step_into() end, { desc = "Debugger step into" })
    vim.keymap.set("n", "<leader>dl", function() dap.run_last() end,
        { desc = "Run last debugging configuration that ran" })
    vim.keymap.set("n", "<leader>dR", function() dap.restart() end, { desc = "Restart the current debugging session" })
    vim.keymap.set("n", "<leader>dp", function() dap.pause() end, { desc = "Pause debugging thread" })
    vim.keymap.set("n", "<leader>da", function() dap.attach() end, { desc = "Pause debugging thread" })
    vim.keymap.set("n", "<leader>ds", function() dap.terminate() end, { desc = "Terminate debugging session" })


    -- Icons and colors
    vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#993939' })
    vim.api.nvim_set_hl(0, 'DapRejected', { ctermbg = 0, fg = '#CC9900' })
    vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = '#61afef' })
    vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#993939', bg = '#98c379' })

    vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
    vim.fn.sign_define('DapBreakpointCondition', { text = '', texthl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
    vim.fn.sign_define('DapBreakpointRejected', { text = '', texthl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
    vim.fn.sign_define('DapLogPoint',
        { text = '', texthl = 'DapLogPoint', linehl = 'DapLogPoint', numhl = 'DapLogPoint' })
    vim.fn.sign_define('DapStopped', { text = '', texthl = 'DapStopped', linehl = 'DapStopped', numhl = 'DapStopped' })


    -- Auto open and close dapui
    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close
else
end

