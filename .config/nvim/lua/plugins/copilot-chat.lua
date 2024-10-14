local M = {
  'CopilotC-Nvim/CopilotChat.nvim',
  branch = 'canary',
  dependencies = {
    { 'github/copilot.vim' },
    { 'nvim-lua/plenary.nvim' },
  },
  cmd = 'CopilotChat',
  opts = function()
    local user = vim.env.USER or 'User'
    user = user:sub(1, 1):upper() .. user:sub(2)
    return {
      auto_insert_mode = true,
      show_help = true,
      question_header = '  ' .. user .. ' ',
      answer_header = '  Copilot ',
      window = {
        width = 0.4,
      },
      selection = function(source)
        local select = require 'CopilotChat.select'
        return select.visual(source) or select.buffer(source)
      end,
    }
  end,
  keys = {
    { '<c-s>', '<CR>', ft = 'copilot-chat', desc = 'Submit Prompt', remap = true },
    { '<leader>m', '', desc = '+ai', mode = { 'n', 'v' } },
    {
      '<leader>mt',
      function()
        return require('CopilotChat').toggle()
      end,
      desc = '[M]Copilot chat [T]oggle',
      mode = { 'n', 'v' },
    },
    {
      '<leader>mx',
      function()
        return require('CopilotChat').reset()
      end,
      desc = '[M]Copilot chat [X]Clear',
      mode = { 'n', 'v' },
    },
    {
      '<leader>mq',
      function()
        local input = vim.fn.input 'Quick Chat: '
        if input ~= '' then
          require('CopilotChat').ask(input)
        end
      end,
      desc = '[M]Copilot chat [Q]uick Chat',
      mode = { 'n', 'v' },
    },
    {
      '<leader>mp',
      function()
        local actions = require 'CopilotChat.actions'
        require('CopilotChat.integrations.telescope').pick(actions.prompt_actions())
      end,
      desc = '[M]Copilot chat [P]rompt actions',
    },
  },
  config = function(_, opts)
    local chat = require 'CopilotChat'
    require('CopilotChat.integrations.cmp').setup()

    vim.api.nvim_create_autocmd('BufEnter', {
      pattern = 'copilot-*',
      callback = function()
        vim.opt_local.relativenumber = false
        vim.opt_local.number = false
      end,
    })

    chat.setup(opts)
  end,
}
return M
