local M = {
  'CopilotC-Nvim/CopilotChat.nvim',
  dependencies = {
    { 'github/copilot.vim' },
    { 'nvim-lua/plenary.nvim' },
  },
  config = function()
    local chat = require 'CopilotChat'
    local prompts = require 'CopilotChat.config.prompts'
    local select = require 'CopilotChat.select'
    local icons = {
      ui = { User = ' ', Bot = ' ' },
      diagnostics = { Error = ' ' },
    }
    local COPILOT_PLAN = [[
You are a software architect and technical planner focused on clear, actionable development plans.
]] .. prompts.COPILOT_BASE.system_prompt .. [[

When creating development plans:
- Start with a high-level overview
- Break down into concrete implementation steps
- Identify potential challenges and their solutions
- Consider architectural impacts
- Note required dependencies or prerequisites
- Estimate complexity and effort levels
- Track confidence percentage (0-100%)
- Format in markdown with clear sections

Always end with:
"Current Confidence Level: X%"
"Would you like to proceed with implementation?" (only if confidence >= 90%)
]]

    chat.setup {
      model = 'claude-3.7-sonnet',
      references_display = 'write',
      debug = false,
      question_header = ' ' .. icons.ui.User .. ' ',
      answer_header = ' ' .. icons.ui.Bot .. ' ',
      error_header = ' ' .. icons.diagnostics.Error .. ' ',
      selection = select.visual,
      context = 'buffers',
      mappings = {
        reset = false,
        ---@diagnostic disable-next-line: missing-fields
        show_diff = {
          full_diff = true,
        },
      },
      prompts = {
        Explain = {
          mapping = '<leader>ae',
          description = 'Copilot Chat Explain',
        },
        Review = {
          mapping = '<leader>ar',
          description = 'Copilot Chat Review',
        },
        Tests = {
          mapping = '<leader>at',
          description = 'Copilot Chat Tests',
        },
        Fix = {
          mapping = '<leader>af',
          description = 'Copilot Chat Fix',
        },
        Optimize = {
          mapping = '<leader>ao',
          description = 'Copilot Chat Optimize',
        },
        Docs = {
          mapping = '<leader>ad',
          description = 'Copilot Chat Documentation',
        },
        Commit = {
          mapping = '<leader>ac',
          description = 'Copilot Chat Generate Commit',
          selection = select.buffer,
        },
        Plan = {
          prompt = 'Create or update the development plan for the selected code. Focus on architecture, implementation steps, and potential challenges.',
          system_prompt = COPILOT_PLAN,
          context = 'file:.copilot/plan.md',
          progress = function()
            return false
          end,
          callback = function(response, source)
            ---@diagnostic disable-next-line: redundant-parameter
            chat.chat:append('Plan updated successfully!', source.winnr)
            local plan_file = source.cwd() .. '/.copilot/plan.md'
            local dir = vim.fn.fnamemodify(plan_file, ':h')
            vim.fn.mkdir(dir, 'p')
            local file = io.open(plan_file, 'w')
            if file then
              file:write(response)
              file:close()
              ---@diagnostic disable-next-line: missing-return
            end
          end,
        },
      },
    }
  end,
  keys = function()
    local chat = require 'CopilotChat'
    return {
      {
        '<leader>aa',
        chat.toggle,
        desc = 'Copilot Chat Toggle',
        mode = { 'n' },
      },
      {
        '<leader>av',
        chat.open,
        desc = 'Copilot Chat Visual',
        mode = { 'v' },
      },
      {
        '<leader>ax',
        chat.reset,
        desc = 'Copilot Chat Reset',
        mode = { 'n' },
      },
      {
        '<leader>as',
        chat.stop,
        desc = 'Copilot Chat Stop',
        mode = { 'n' },
      },
      {
        '<leader>am',
        chat.select_model,
        desc = 'Copilot Chat Select Model',
        mode = { 'n' },
      },
      {
        '<leader>ag',
        chat.select_agent,
        desc = 'Copilot Chat Select Agent',
        mode = { 'n' },
      },
      {
        '<leader>ap',
        chat.select_prompt,
        desc = 'Copilot Chat Select Prompt',
        mode = { 'n', 'v' },
      },
      {
        '<leader>aq',
        function()
          vim.ui.input({ prompt = 'Copilot Question> ' }, function(input)
            if input then
              chat.ask(input)
            end
          end)
        end,
        desc = 'Copilot Chat Quick Chat',
        mode = { 'n', 'v' },
      },
    }
  end,
}
return M
