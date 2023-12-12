if vim.g.vscode == false then
local test = require("neotest")

-- Keymaps for running tests
vim.keymap.set("n", "<leader>tn", function() test.run.run() end, { desc = "Run nearest test" })
vim.keymap.set("n", "<leader>tf", function() test.run.run({ vim.fn.expand("%") }) end, { desc = "Run all tests in file" })
vim.keymap.set("n", "<leader>tN", function() test.run.run({ strategy = "dap" }) end,
    { desc = "Run nearest test with debugger" })
vim.keymap.set("n", "<leader>tF", function() test.run.run({ vim.fn.expand("%"), strategy = "dap" }) end,
    { desc = "Run all tests in file with debugger" })
vim.keymap.set("n", "<leader>ts", function() test.run.stop() end, { desc = "Stop running tests" })
vim.keymap.set("n", "<leader>ta", function() test.run.attach() end, { desc = "Attach to running tests" })
vim.keymap.set("n", "<leader>tl", function() test.run.run_last() end, { desc = "Run last ran test" })
vim.keymap.set("n", "<leader>tL", function() test.run.run_last({ strategy = "dap" }) end,
    { desc = "Run last ran test with debugger" })

-- keymaps for watching tests
vim.keymap.set("n", "<leader>tw", function() test.watch.toggle() end, { desc = "Toggle watching test" })
vim.keymap.set("n", "<leader>tW", function() test.watch.toggle(vim.fn.expand("%")) end,
    { desc = "Toggle watching tests in file" })
vim.keymap.set("n", "<leader>ts", function() test.summary.toggle() end, { desc = "Toggle test summary panel" })

-- Keymaps for navigating results
vim.keymap.set("n", "<leader>to", function() test.output.open({ enter = true, auto_close = true }) end,
    { desc = "Open test output" })

else
end