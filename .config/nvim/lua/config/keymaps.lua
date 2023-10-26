vim.keymap.set("n", "<leader>pv", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>")

vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv") -- move lines down
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv") -- move lines up
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==")     -- move line down
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==")     -- move line up

vim.keymap.set("n", "J", "mzJ`z")                -- join lines without spaces
vim.keymap.set("n", "<C-d>", "<C-d>zz")          -- keep cursor in the middle of the screen when scrolling down
vim.keymap.set("n", "<C-u>", "<C-u>zz")          -- keep cursor in the middle of the screen when scrolling up

vim.keymap.set("n", "n", "nzzzv")                -- keep cursor in the middle of the screen when jumping to next match
vim.keymap.set("n", "N", "Nzzzv")                -- keep cursor in the middle of the screen when jumping to next match

vim.keymap.set("x", "<leader>p", "\"_dp")        -- paste without yanking
vim.keymap.set("n", "<leader>p", "\"+p")         -- paste from system clipboard

vim.keymap.set("n", "<leader>d", "\"+dd")        -- delete to system clipboard
vim.keymap.set("v", "<leader>d", "\"+d")         -- delete to system clipboard (visual)
vim.keymap.set("n", "<leader>D", "\"+D")         -- delete to system clipboard (line)
vim.keymap.set("n", "<leader>y", "\"+yy")        -- yank to system clipboard
vim.keymap.set("v", "<leader>y", "\"+y")         -- yank to system clipboard (visual)
vim.keymap.set("n", "<leader>Y", "\"+Y")         -- yank to system clipboard (line)

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-">\>/<C-r><C-">/gI<Left><Left><Left>]]) -- search and replace in file
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })              -- make file executable
vim.keymap.set({ "i", "v" }, "<C-c>", "<Esc>")
