local M = {
    'nvim-telescope/telescope.nvim',
    enabled = function()
        return vim.g.vscode == nil
    end,
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        'nvim-tree/nvim-web-devicons'
    },
    config = function()
        local builtin = require("telescope.builtin")
        local actions = require("telescope.actions")
        local trouble = require("trouble.providers.telescope")
        local telescope = require('telescope')

        telescope.setup({
            defaults = {
                path_display = { 'truncate ' },
                mappings = {
                    i = {
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                        ["<C-e>"] = actions.smart_add_to_qflist,
                        ["<C-t>"] = trouble.open_with_trouble
                    },
                    n = {
                        ["<C-t>"] = trouble.open_with_trouble
                    }
                }
            }
        })

        telescope.load_extension('fzf')



        -- Telescope live_grep in git root
        -- Function to find the git root directory based on the current buffer's path
        local function find_git_root()
            -- Use the current buffer's path as the starting point for the git search
            local current_file = vim.api.nvim_buf_get_name(0)
            local current_dir
            local cwd = vim.fn.getcwd()
            -- If the buffer is not associated with a file, return nil
            if current_file == "" then
                current_dir = cwd
            else
                -- Extract the directory from the current file's path
                current_dir = vim.fn.fnamemodify(current_file, ":h")
            end

            -- Find the Git root directory from the current file's path
            local git_root = vim.fn.systemlist("git -C " ..
                vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")[1]
            if vim.v.shell_error ~= 0 then
                print("Not a git repository. Searching on current working directory")
                return cwd
            end
            return git_root
        end

        -- Custom live_grep function to search in git root
        local function live_grep_git_root()
            local git_root = find_git_root()
            if git_root then
                builtin.live_grep({
                    search_dirs = { git_root },
                })
            end
        end

        -- Custom find files function to seach in git root
        local function find_files_git_root()
            local git_root = find_git_root()
            if git_root then
                require("telscope.builtin").find_files({
                    search_dirs = { git_root },
                })
            end
        end

        vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})
        vim.api.nvim_create_user_command('FindFilesGitRoot', find_files_git_root, {})


        vim.keymap.set("n", "<leader>sf", function() builtin.find_files({ hidden = true }) end,
            { desc = "Fuzzy find files from cwd" })
        vim.keymap.set("n", "<leader>sF", ':FindFilesGitRoot', { desc = "Fuzzy find files from git root" })
        vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "Seach help" })
        vim.keymap.set("n", "<leader>sg", builtin.git_files, { desc = "Fuzzy find files tracked by git" })
        vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "Grep word" })
        vim.keymap.set("n", "<leader>sl", builtin.live_grep, { desc = "Grep live in cwd" })
        vim.keymap.set("n", "<leader>sL", ':LiveGrepGitRoot', { desc = "Grep live in cwd" })
        vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "Seacrh diagnostics" })
        vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "Resume Search" })

        vim.keymap.set('n', '<leader>?', builtin.oldfiles,
            { desc = '[?] Find recently opened files' })

        vim.keymap.set('n', '<leader><space>', builtin.buffers,
            { desc = '[ ] Find existing buffers' })

        vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find,
            { desc = '[/] Fuzzily search in current buffer' })
    end

}

return M
