local M = {
	'nvim-telescope/telescope.nvim', branch = '0.1.x',
	dependencies = { 'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        'nvim-tree/nvim-web-devicons'
    },
	config = function() 
		local builtin = require("telescope.builtin")
        local actions = require("telescope.actions")
        local telescope = require('telescope')

        telescope.setup({
            defaults = {
                path_display = { 'truncate '},
                mappings = {
                    i = {
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                    }
                }
            }
        })

        telescope.load_extension('fzf')

		vim.keymap.set("n", "<leader>ff", builtin.find_files, {})        -- find files
		vim.keymap.set("n", "<leader>fg", builtin.git_files, {})         -- find git files
		vim.keymap.set("n", "<leader>gp", function()                     -- grep project
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end)
	end
}

return M
