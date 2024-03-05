vim.keymap.set("n", "n", "nzzzv", { desc = "Keep cursor in the middle while jumping to next match" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Keep cursor in the middle while jumping to previous match" })
vim.keymap.set("n", "<leader>c", ":nohl<CR>", { desc = "Clear highlights" })


vim.keymap.set("x", "<leader>p", "\"_dp", { desc = "Paste without yanking" })
vim.keymap.set("n", "<leader>p", "\"+p", { desc = "Paste from system clipboard" })

vim.keymap.set("n", "<leader>d", "\"+dd", { desc = "Delete whole line to system clipboard" })
vim.keymap.set("v", "<leader>d", "\"+d", { desc = "Delete selection to system clipboard" })
vim.keymap.set("n", "<leader>D", "\"+D", { desc = "Delete remaining line to system clipboard" })
vim.keymap.set("n", "<leader>y", "\"+yy", { desc = "Yank whole line to system clipboard" })
vim.keymap.set("v", "<leader>y", "\"+y", { desc = "Yank selection to system clipboard" })
vim.keymap.set("n", "<leader>Y", "\"+Y", { desc = "Yank remaining line to system clipboard" })

vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { desc = "Make current file executable", silent = true })
vim.keymap.set({ "i", "v" }, "<C-c>", "<Esc>", { desc = "Ctrl+c behaves like Esc" })

-- Qucikfix list navigation
if vim.g.vscode == false or vim.g.vscode == nil then
	vim.keymap.set("n", "<leader>qo", ":copen<CR>", { desc = "Open quickfix list" })
	vim.keymap.set("n", "<leader>qc", ":ccl<CR>", { desc = "Close quickfix list" })
	vim.keymap.set("n", "<leader>qn", ":cnext<CR>", { desc = "Go to next item in the quickfix list" })
	vim.keymap.set("n", "<leader>qp", ":cprev<CR>", { desc = "Go to the previous item in the quickfix list" })

	vim.keymap.set("x", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
	vim.keymap.set("x", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })
	vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
	vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })

	vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines without spaces" })
	vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Keep cursor in the middle while scrolling down" })
	vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Kepp cursor in the middle while scrolling up" })

	vim.keymap.set(
		"n",
		"<leader>pv",
		"<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>",
		{ desc = "Open file browser at current file's path" }
	)
else
end
