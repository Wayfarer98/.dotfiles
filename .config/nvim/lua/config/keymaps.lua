-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Keep cursor in the middle while jumping to next match
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Keep cursor in the middle while jumping to next match' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Keep cursor in the middle while jumping to previous match' })

-- Keep cursor in the middle while scrolling
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Keep cursor in the middle while scrolling down' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Keep cursor in the middle while scrolling up' })

-- Remove highlights
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Move lines up and down
vim.keymap.set('x', '<A-j>', ":m '>+1<CR>gv=gv", { desc = 'Move selected lines down' })
vim.keymap.set('x', '<A-k>', ":m '<-2<CR>gv=gv", { desc = 'Move selected lines up' })
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', { desc = 'Move line down' })
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', { desc = 'Move line up' })

-- Indent lines but stay in visual mode
vim.keymap.set('x', '<', '<gv', { desc = 'Indent selected lines left' })
vim.keymap.set('x', '>', '>gv', { desc = 'Indent selected lines right' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Splitting windows
vim.keymap.set('n', '<C-w>-', '<cmd>split<CR>', { desc = 'Split window horizontally' })
vim.keymap.set('n', '<C-w>|', '<cmd>vsplit<CR>', { desc = 'Split window vertically' })

-- Keymaps for yanking and pasting to system clipboard
vim.keymap.set('x', '<leader>p', '"_dp', { desc = 'Paste without yanking' })
vim.keymap.set('n', '<leader>p', '"+p', { desc = 'Paste below from system clipboard' })
vim.keymap.set('n', '<leader>P', '"+P', { desc = 'Paste above from system clipboard' })
vim.keymap.set('n', '<leader>d', '"+d', { desc = 'Start deletion to system clipboard' })
vim.keymap.set('v', '<leader>d', '"+d', { desc = 'Delete selection to system clipboard' })
vim.keymap.set('n', '<leader>D', '"+D', { desc = 'Delete remaining line to system clipboard' })
vim.keymap.set('n', '<leader>y', '"+y', { desc = 'Start yanking to system clipboard' })
vim.keymap.set('v', '<leader>y', '"+y', { desc = 'Yank selection to system clipboard' })
vim.keymap.set('n', '<leader>Y', '"+Y', { desc = 'Yank remaining line to system clipboard' })

-- Copilot keymaps
vim.keymap.set('i', '<M-y>', 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false, desc = 'Accept copilot suggestion' })
vim.keymap.set('i', '<M-w>', '<Plug>(copilot-accept-word)', { desc = 'Accept copilot word' })
vim.keymap.set('i', '<M-l>', '<Plug>(copilot-accept-line)', { desc = 'Accept copilot line' })
vim.keymap.set('i', '<M-e>', '<Plug>(copilot-dismiss)', { desc = 'Dismiss copilot suggestion' })
vim.keymap.set('i', '<M-n>', '<Plug>(copilot-next)', { desc = 'Copilot next suggestion' })
vim.keymap.set('i', '<M-p>', '<Plug>(copilot-previous)', { desc = 'Copilot previous suggestion' })
vim.keymap.set('i', '<M-\\>', '<Plug>(copilot-suggest)', { desc = 'Copilot force suggestion' })
