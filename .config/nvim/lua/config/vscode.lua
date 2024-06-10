local vscode = require("vscode-neovim")

-- fzf
vim.keymap.set('n', '<leader>sl', function() vscode.call('fzf-quick-open.runFzfSearch') end)
vim.keymap.set('n', '<leader>sL', function() vscode.call('fzf-quick-open.runFzfSearchProjectRoot') end)
vim.keymap.set('n', '<leader>sf', function() vscode.call('fzf-quick-open.runFzfFile') end)
vim.keymap.set('n', '<leader>sg', function() vscode.call('fzf-quick-open.runFzfFileProjectRoot') end)

-- Multiple cursors
vim.keymap.set('n', '<C-e>', 'mciw*<Cmd>nohl<CR>', { remap = true })
vim.keymap.set({ "x", "i" }, "<C-e>", function()
	require("vscode-multi-cursor").addSelectionToNextFindMatch()
end)

-- Format document
vim.keymap.set("n", "<leader>f", function() vscode.call("editor.action.formatDocument") end)
vim.keymap.set("x", "<leader>f", function() vscode.call("editor.action.formatSelection") end)
vim.keymap.set("n", "u", function() vscode.call("undo") end)
vim.keymap.set("n", "<C-r>", function() vscode.call("redo") end)

-- Refactoring
vim.keymap.set({ "n", "x" }, "<leader>r", function ()
	vscode.with_insert(function()
		vscode.action("editor.action.refactor")
	end)
end)

-- Comments
vim.keymap.set("n", "gcc", function() vscode.call("editor.action.commentLine") end)
vim.keymap.set("x", "gc", function() vscode.call("editor.action.commentLine") end)
vim.keymap.set("x", "gb", function() vscode.call("editor.action.blockComment") end)

-- Copilot
vim.keymap.set("i", "<M-l>", function() vscode.call("editor.action.inlineSuggest.acceptNextLine") end)
vim.keymap.set("i", "<M-w>", function() vscode.call("editor.action.inlineSuggest.acceptNextWord") end)
vim.keymap.set("i", "<M-d>", function() vscode.call("editor.action.inlineSuggest.hide") end)

-- lsp
vim.keymap.set("n", "gd", function() vscode.call("editor.action.peekDefinition") end)
vim.keymap.set("n", "gD", function() vscode.call("editor.action.revealDefinition") end)
vim.keymap.set("n", "gt", function() vscode.call("editor.action.peekTypeDefinition") end)
vim.keymap.set("n", "gT", function() vscode.call("editor.action.goToTypeDefinition") end)
vim.keymap.set("n", "K", function() vscode.call("editor.action.showHover") end)
vim.keymap.set("n", "gi", function() vscode.call("editor.action.peekImplementation") end)
vim.keymap.set("n", "gI", function() vscode.call("editor.action.goToImplementation") end)
vim.keymap.set("n", "gR", function() vscode.call("editor.action.goToReferences") end)
vim.keymap.set("n", "gr", function() vscode.action("editor.action.referenceSearch.trigger") end)
vim.keymap.set("n", "ga", function() vscode.call("editor.action.quickFix") end)
vim.keymap.set("n", "gs", function() vscode.call("editor.action.triggerParameterHints") end)
vim.keymap.set("n", "gl", function() vscode.call("workbench.actions.view.problems") end)
vim.keymap.set("n", "gn", function() vscode.call("editor.action.marker.next") end)
vim.keymap.set("n", "gp", function() vscode.call("editor.action.marker.prev") end)
