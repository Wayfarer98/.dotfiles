local prompts = {
  Explain = 'Please explain how the following code works.',
  Review = 'Please review the following code and provide suggestions for improvement.',
  Tests = 'Please explain how the selected code works, then generate unit tests for it.',
  Refactor = 'Please refactor the following code to improve its clarity and readability.',
  FixCode = 'Please fix the following code to make it work as intended.',
  FixError = 'Please explain the error in the following text and provide a solution.',
  BetterNamings = 'Please provide better names for the following variables and functions.',
  Documentation = 'Please provide documentation for the following code.',
  -- Text related prompts
  Summarize = 'Please summarize the following text.',
  Spelling = 'Please correct any grammar and spelling errors in the following text.',
  Wording = 'Please improve the grammar and wording of the following text.',
  Concise = 'Please rewrite the following text to make it more concise.',
}

local M = {
  'CopilotC-Nvim/CopilotChat.nvim',
  branch = 'main',
  dependencies = {
    { 'github/copilot.vim' },
    { 'nvim-lua/plenary.nvim' },
  },
  opts = {
    auto_insert_mode = true,
    show_help = true,
    question_header = '#   ',
    answer_header = '#   ',
    error_header = '> [!ERROR] Error ',
    separator = '---',
    window = {
      width = 0.4,
    },
    prompts = prompts,
    mappings = {
      complete = {
        insert = '<C-y>',
      },
      close = {
        normal = 'q',
        insert = '<C-c>',
      },
      reset = {
        normal = '<C-x',
        insert = '<C-x>',
      },
      submit_prompt = {
        normal = '<CR>',
        insert = '<C-CR>',
      },
      accept_diff = {
        normal = '<C-y>',
        insert = '<C-y>',
      },
      yank_diff = {
        normal = 'gmy',
      },
      show_diff = {
        normal = 'gmd',
      },
      show_system_promp = {
        normal = 'gmp',
      },
      show_context = {
        normal = 'gms',
      },
      show_help = {
        normal = 'gmh',
      },
    },
  },
  config = function(_, opts)
    local chat = require 'CopilotChat'
    local select = require 'CopilotChat.select'
    -- use unnamed register for the selection
    opts.selection = select.unnamed

    chat.setup(opts)

    vim.api.nvim_create_user_command('CopilotChatVisual', function(args)
      chat.ask(args.args, { selection = select.visual })
    end, { nargs = '*', range = true })

    vim.api.nvim_create_user_command('CopilotChatInline', function(args)
      chat.ask(args.args, {
        selection = select.visual,
        window = {
          layout = 'float',
          relative = 'cursor',
          width = 1,
          height = 0.4,
          row = 1,
        },
      })
    end, { nargs = '*', range = true })

    -- restore CopilotChatBuffer
    vim.api.nvim_create_user_command('CopilotChatBuffer', function(args)
      chat.ask(args.args, { selection = select.buffer })
    end, { nargs = '*', range = true })
    vim.api.nvim_create_autocmd('BufEnter', {
      pattern = 'copilot-*',
      callback = function()
        vim.opt_local.relativenumber = true
        vim.opt_local.number = true

        -- Get current filetype and set it to markdown if the current filetype is copilot-chat
        -- local ft = vim.bo.filetype
        -- if ft == 'copilot-chat' then
        --   vim.bo.filetype = 'markdown'
        -- end
      end,
    })
  end,
  event = 'VeryLazy',
  keys = {
    -- Code related commands
    {
      '<leader>ae',
      '<cmd>CopilotChatExplain<cr>',
      desc = 'CopilotChat - Explain Code',
    },
    {
      '<leader>aT',
      '<cmd>CopilotChatTest<cr>',
      desc = 'CopilotChat - Generate Tests',
    },
    {
      '<leader>ar',
      '<cmd>CopilotChatReview<cr>',
      desc = 'CopilotChat - Review Code',
    },
    {
      '<leader>aR',
      '<cmd>CopilotChatRefactor<cr>',
      desc = 'CopilotChat - Refactor Code',
    },
    {
      '<leader>an',
      '<cmd>CopilotChatBetterNamings<cr>',
      desc = 'CopilotChat - Better Naming',
    },
    -- Chat with Copilot in visual mode
    {
      '<leader>av',
      '<cmd>CopilotChatVisual<cr>',
      mode = 'x',
      desc = 'CopilotChat - Open in vertical split (visual)',
    },
    {
      '<leader>ax',
      '<cmd>CopilotChatInline<cr>',
      mode = 'x',
      desc = 'CopilotChat - Inline chat (visual)',
    },
    -- Custom input for CopilotChat
    {
      '<leader>ai',
      function()
        local input = vim.fn.input 'Ask Copilot: '
        if input ~= '' then
          vim.cmd('CopilotChat ' .. input)
        end
      end,
      desc = 'CopilotChat - Ask input',
    },
    -- Generate commit message based on git diff
    {
      '<leader>am',
      '<cmd>CopilotChatCommit<cr>',
      desc = 'CopilotChat - Generate commit message for all changes',
    },
    -- Quick chat with Copilot
    {
      '<leader>aq',
      function()
        local input = vim.fn.input 'Qucik Chat: '
        if input ~= '' then
          vim.cmd('CopilotChatBuffer ' .. input)
        end
      end,
      desc = 'CopilotChat - Quick chat',
    },
    -- Debug
    {
      '<leader>ad',
      '<cmd>CopilotChatDebugInfo<cr>',
      desc = 'CopilotChat - Debug Info',
    },
    -- Fix the issues with diagnostics
    {
      '<leader>af',
      '<cmd>CopilotChatFixDiagnostic<cr>',
      desc = 'CopilotChat - Fix Diagnostic',
    },
    -- Clear buffer and chat history
    {
      '<leader>al',
      '<cmd>CopilotChatReset<cr>',
      desc = 'CopilotChat - Clear buffer and chat history',
    },
    -- Toggle chat
    {
      '<leader>at',
      '<cmd>CopilotChatToggle<cr>',
      desc = 'CopilotChat - Toggle',
    },
    -- Copilot Chat Models
    {
      '<leader>a?',
      '<cmd>CopilotChatModels<cr>',
      desc = 'CopilotChat - Select Models',
    },
  },
}
return M
