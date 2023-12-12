return {
	"folke/trouble.nvim",
	enabled = function()
		return vim.g.vscode == nil
	end,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
	},
}
