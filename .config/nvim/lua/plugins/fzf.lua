local M = {
  'ibhagwan/fzf-lua',
  dependencies = {
    'echasnovski/mini.icons',
    'nvim-treesitter/nvim-treesitter-context',
    'OXY2DEV/markview.nvim',
  },
  cmd = 'FzfLua',
  opts = function()
    local fzf = require 'fzf-lua'
    local actions = fzf.actions
    local actions_trouble = require('trouble.sources.fzf').actions
    local config = fzf.config

    -- quickfix
    config.defaults.keymap.fzf['ctrl-q'] = 'select-all+accept'
    config.defaults.keymap.fzf['ctrl-u'] = 'half-page-up'
    config.defaults.keymap.fzf['ctrl-d'] = 'half-page-down'
    config.defaults.keymap.fzf['ctrl-x'] = 'jump'
    config.defaults.keymap.fzf['ctrl-f'] = 'preview-page-down'
    config.defaults.keymap.fzf['ctrl-b'] = 'preview-page-up'
    config.defaults.keymap.builtin['<c-f>'] = 'preview-page-down'
    config.defaults.keymap.builtin['<c-b>'] = 'preview-page-up'

    -- trouble
    config.defaults.actions.files['ctrl-t'] = actions_trouble.open
    config.defaults.actions.files['ctrl-e'] = actions_trouble.add

    -- Check for image previewer
    local img_previewer ---@type string[]?
    for _, v in ipairs {
      { cmd = 'ueberzug', args = {} },
      { cmd = 'chafa', args = { '{file}', '--format=symbols' } },
      { cmd = 'viu', args = { '-b' } },
    } do
      if vim.fn.executable(v.cmd) == 1 then
        img_previewer = vim.list_extend({ v.cmd }, v.args)
        break
      end
    end

    return {
      'default-title',
      fzf_colors = true,
      fzf_opts = {
        ['--no-scrollbar'] = true,
      },
      defaults = {
        file_icons = 'mini',
      },
      previewers = {
        builtin = {
          extensions = {
            ['png'] = img_previewer,
            ['jpg'] = img_previewer,
            ['jpeg'] = img_previewer,
            ['gif'] = img_previewer,
            ['webp'] = img_previewer,
          },
        },
      },
      files = {
        actions = {
          ['alt-i'] = { actions.toggle_ignore },
          ['alt-h'] = { actions.toggle_hidden },
        },
      },
      grep = {
        actions = {
          ['alt-i'] = { actions.toggle_ignore },
          ['alt-h'] = { actions.toggle_hidden },
        },
      },
      oldfiles = {
        include_current_session = true,
      },
    }
  end,
  keys = function()
    local fzf = require 'fzf-lua'
    return {
      -- Move with <c-j> and <c-k> in fzf terminal window
      { '<c-j>', '<c-j>', ft = 'fzf', mode = 't', nowait = true },
      { '<c-k>', '<c-k>', ft = 'fzf', mode = 't', nowait = true },

      -- Buffers and Files
      {
        '<leader>fb',
        function()
          fzf.buffers { sort_mru = true, sort_lastused = true }
        end,
        desc = 'Find open buffer',
      },
      {
        '<leader>ff',
        fzf.files,
        desc = 'Find files (root dir)',
      },
      {
        '<leader>fF',
        function()
          fzf.files { cwd = vim.fn.expand '%:p:h' }
        end,
        desc = 'Find files (dir of current file)',
      },
      {
        '<leader>fc',
        function()
          fzf.files { cwd = vim.fn.expand '$HOME/.config/nvim' }
        end,
        desc = 'Find Config files',
      },
      {
        '<leader>fT',
        fzf.treesitter,
        desc = 'Find Treesitter symbols',
      },
      {
        '<leader>ft',
        function()
          fzf.files { cwd = vim.fn.expand '$HOME/.config/wezterm' }
        end,
        desc = 'Find files in wezterm config',
      },
      {
        '<leader>fr',
        fzf.oldfiles,
        desc = 'Find recent files',
      },
      {
        '<leader>fq',
        fzf.quickfix_stack,
        desc = 'Find quickfix list',
      },

      -- Search with grep
      {
        '<leader>sg',
        fzf.live_grep_glob,
        desc = 'Search live (root dir)',
      },
      {
        '<leader>sG',
        function()
          fzf.live_grep_glob { cwd = vim.fn.expand '%:p:h' }
        end,
        desc = 'Search live (dir of current file)',
      },
      {
        '<leader>sv',
        fzf.grep_visual,
        mode = 'v',
        desc = 'Search visual selection (root dir)',
      },
      {
        '<leader>sV',
        function()
          fzf.grep_visual { cwd = vim.fn.expand '%:p:h' }
        end,
        mode = 'v',
        desc = 'Search visual selection',
      },
      {
        '<leader>sw',
        fzf.grep_cword,
        desc = 'Search word (root dir)',
      },
      {
        '<leader>sW',
        fzf.grep_cWORD,
        desc = 'Search WORD (root dir)',
      },
      {
        '<leader>sq',
        fzf.lgrep_quickfix,
        desc = 'Search quickfix list',
      },
      {
        '<leader>sl',
        fzf.lgrep_loclist,
        desc = 'Search location list',
      },
      {
        '<leader>sc',
        function()
          fzf.live_grep_glob { cwd = vim.fn.expand '$HOME/.config/nvim' }
        end,
        desc = 'Search in neovim files',
      },
      {
        '<leader>sb',
        fzf.builtin,
        desc = 'Search fzf builtin commands',
      },
      {
        '<leader>sh',
        fzf.helptags,
        desc = 'Search helptags',
      },
      {
        '<leader>sH',
        fzf.highlights,
        desc = 'Search highlight groups',
      },
      {
        '<leader>sC',
        fzf.commands,
        desc = 'Search neovim commands',
      },
      {
        '<leader>sa',
        fzf.autocmds,
        desc = 'Search autocmds',
      },
      {
        '<leader>sk',
        fzf.keymaps,
        desc = 'Search keymaps',
      },
      {
        '<leader>sm',
        fzf.manpages,
        desc = 'Search manpages',
      },

      -- Git
      {
        '<leader>gf',
        fzf.git_files,
        desc = 'Git files files',
      },
      {
        '<leader>gc',
        fzf.git_commits,
        desc = 'Search git commits',
      },
      {
        '<leader>gC',
        fzf.git_bcommits,
        desc = 'Search git commits (buffer)',
      },
      {
        '<leader>gs',
        fzf.git_status,
        desc = 'Git status',
      },
      {
        '<leader>gS',
        fzf.git_stash,
        desc = 'Git stash',
      },
      {
        '<leader>gb',
        fzf.git_branches,
        desc = 'Git branches',
      },
      {
        '<leader>gB',
        fzf.git_blame,
        desc = 'Git blame',
      },
      {
        '<leader>gt',
        fzf.git_tags,
        desc = 'Git tags',
      },

      -- DAP
      {
        '<leader>bc',
        fzf.dap_commands,
        desc = 'DAP commands',
      },
      {
        '<leader>bC',
        fzf.dap_configurations,
        desc = 'DAP configurations',
      },
      {
        '<leader>bb',
        fzf.dap_breakpoints,
        desc = 'DAP breakpoints',
      },

      {
        '<leader>/',
        function()
          fzf.grep_curbuf {
            winopts = {
              height = 0.5,
              width = 0.5,
              preview = { layout = 'vertical', vertical = 'down:50%' },
            },
          }
        end,
        desc = 'Search lines in current buffer',
      },
    }
  end,
}

return M
