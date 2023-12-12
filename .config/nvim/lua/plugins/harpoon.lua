local M = {
	"ThePrimeagen/harpoon",
	enabled = function()
		return vim.g.vscode == nil
	end,
	dependencies = {
		"nvim-lua/plenary.nvim",
	}
}

return M
