local test = require("neotest")

-- Keymaps for running tests
vim.keymap.set("n", "<leader>nn", function () test.run.run() end)
vim.keymap.set("n", "<leader>nf", function () test.run.run({vim.fn.expand("%")}) end)
vim.keymap.set("n", "<leader>nN", function () test.run.run({strategy = "dap"}) end)
vim.keymap.set("n", "<leader>nF", function () test.run.run({vim.fn.expand("%"), strategy = "dap"}) end)
vim.keymap.set("n", "<leader>ns", function () test.run.stop() end)
vim.keymap.set("n", "<leader>na", function () test.run.attach() end)
vim.keymap.set("n", "<leader>nl", function () test.run.run_last() end)
vim.keymap.set("n", "<leader>nL", function () test.run.run_last({strategy = "dap"}) end)

-- keymaps for watching tests
vim.keymap.set("n", "<leader>nw", function () test.watch.toggle() end)
vim.keymap.set("n", "<leader>nW", function () test.watch.toggle(vim.fn.expand("%")) end)
vim.keymap.set("n", "<leader>ns", function () test.summary.toggle() end)

-- Keymaps for navigating results
vim.keymap.set("n", "<leader>no", function () test.output.open({enter = true, auto_close = true}) end)

