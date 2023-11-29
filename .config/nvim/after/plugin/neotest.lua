local test = require("neotest")

-- Keymaps for running tests
vim.keymap.set("n", "<leader>trn", function () test.run.run() end)
vim.keymap.set("n", "<leader>trf", function () test.run.run(vim.fn.expand("%")) end)
vim.keymap.set("n", "<leader>trd", function () test.run.run({strategy = "dap"}) end)
vim.keymap.set("n", "<leader>trs", function () test.run.stop() end)
vim.keymap.set("n", "<leader>tra", function () test.run.attach() end)
vim.keymap.set("n", "<leader>trl", function () test.run.run_last() end)
vim.keymap.set("n", "<leader>trld", function () test.run.run_last({strategy = "dap"}) end)

-- keymaps for watching tests
vim.keymap.set("n", "<leader>twt", function () test.watch.toggle() end)
vim.keymap.set("n", "<leader>twf", function () test.watch.toggle(vim.fn.expand("%")) end)
vim.keymap.set("n", "<leader>tws", function () test.watch.stop() end)
vim.keymap.set("n", "<leader>tts", function () test.status() end)
vim.keymap.set("n", "<leader>tso", function () test.summary.open() end)
vim.keymap.set("n", "<leader>tsc", function () test.summary.close() end)



-- Keymaps for navigating results

