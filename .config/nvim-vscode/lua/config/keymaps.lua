--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Keep cursor in the middle while jumping to next match
vim.keymap.set("n", "n", "nzzzv", {
    desc = "Keep cursor in the middle while jumping to next match"
})
vim.keymap.set("n", "N", "Nzzzv", {
    desc = "Keep cursor in the middle while jumping to previous match"
})

-- Keep cursor in the middle while scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz", {
    desc = "Keep cursor in the middle while scrolling down"
})
vim.keymap.set("n", "<C-u>", "<C-u>zz", {
    desc = "Keep cursor in the middle while scrolling up"
})

-- Remove highlights
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Keep selection on indentation of lines
vim.keymap.set("v", "<", "<gv", {
    desc = "Indent lines left"
})
vim.keymap.set("v", ">", ">gv", {
    desc = "Indent lines right"
})

-- Keymaps for yanking and pasting to system clipboard
vim.keymap.set("x", "<leader>p", '"_dp', {
    desc = "Paste without yanking"
})
vim.keymap.set("n", "<leader>p", '"+p', {
    desc = "Paste below from system clipboard"
})
vim.keymap.set("n", "<leader>P", '"+P', {
    desc = "Paste above from system clipboard"
})
vim.keymap.set("n", "<leader>d", '"+d', {
    desc = "Start deletion to system clipboard"
})
vim.keymap.set("v", "<leader>d", '"+d', {
    desc = "Delete selection to system clipboard"
})
vim.keymap.set("n", "<leader>D", '"+D', {
    desc = "Delete remaining line to system clipboard"
})
vim.keymap.set("n", "<leader>y", '"+y', {
    desc = "Start yanking to system clipboard"
})
vim.keymap.set("v", "<leader>y", '"+y', {
    desc = "Yank selection to system clipboard"
})
vim.keymap.set("n", "<leader>Y", '"+Y', {
    desc = "Yank remaining line to system clipboard"
})
