local M = {
	"folke/flash.nvim",
	event = "VeryLazy",
	---@type Flash.Config
	opts = {
		label = {
			after = false,
			before = true,
		},
		highlight = {
			backdrop = false
		}
	},
	-- stylua: ignore
	keys = {
		{ "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,   desc = "Flash" },
		{ "r",     mode = "o",               function() require("flash").remote() end, desc = "Remote Flash" },
		{ "<c-s>", mode = { "c" },           function() require("flash").toggle() end, desc = "Toggle Flash Search" },
	},
}

return M
