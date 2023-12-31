-- go to last loc when opening a buffer
if vim.g.vscode == nil then

else
	vim.api.nvim_create_autocmd("BufReadPost", {
		callback = function()
			local mark = vim.api.nvim_buf_get_mark(0, '"')
			local lcount = vim.api.nvim_buf_line_count(0)
			if mark[1] > 0 and mark[1] <= lcount then
				pcall(vim.api.nvim_win_set_cursor, 0, mark)
			end
		end,
	})

	vim.api.nvim_create_autocmd("FileType", {
		pattern = { "gitcommit", "markdown" },
		callback = function()
			vim.opt_local.wrap = true
			vim.opt_local.spell = true
		end,
	})

	-- Check if we need to reload the file when it changed
	vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, { command = "checktime" })

	vim.api.nvim_create_autocmd("ColorScheme", {
		pattern = "*",
		callback = function()
			package.loaded["feline"] = nil
			package.loaded["catppuccin.groups.integrations.feline"] = nil
			require("feline").setup {
				components = require("catppuccin.groups.integrations.feline").get(),
			}
		end,
	})

	-- [[ Highlight on yank ]]
	-- See `:help vim.highlight.on_yank()`
	local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
	vim.api.nvim_create_autocmd('TextYankPost', {
		callback = function()
			vim.highlight.on_yank()
		end,
		group = highlight_group,
		pattern = '*',
	})
end
