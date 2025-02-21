local M = { -- Autocompletion
  'hrsh7th/nvim-cmp',
  enabled = true,
  event = { 'InsertEnter', 'CmdlineEnter' },
  dependencies = {
    -- Snippet Engine & its associated nvim-cmp source
    {
      'L3MON4D3/LuaSnip',
      build = (function()
        if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
          return
        end
        return 'make install_jsregexp'
      end)(),
      dependencies = {},
    },
    'saadparwaiz1/cmp_luasnip',

    -- Adds other completion capabilities.
    --  nvim-cmp does not ship with all sources by default. They are split
    --  into multiple repos for maintenance purposes.
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-buffer',
  },

  config = function()
    -- See `:help cmp`
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'

    luasnip.config.setup {}

    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      formatting = {
        format = function(_, vim_item)
          local icon, hl = require('mini.icons').get('lsp', vim_item.kind)
          vim_item.kind = icon .. ' ' .. vim_item.kind
          vim_item.kind_hl_group = hl
          return vim_item
        end,
        fields = { 'abbr', 'kind', 'menu' },
        expandable_indicator = false,
      },
      completion = { completeopt = 'menuone,noselect' },

      -- For an understanding of why these mappings were
      -- chosen, you will need to read `:help ins-completion`
      --
      -- No, but seriously. Please read `:help ins-completion`, it is really good!
      mapping = cmp.mapping.preset.insert {
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-e>'] = cmp.mapping.close(),
        ['<C-y>'] = cmp.mapping.confirm { select = true },
        ['<C-Space>'] = cmp.mapping.complete {},
        ['<C-l>'] = cmp.mapping(function()
          if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          end
        end, { 'i', 's' }),
        ['<C-h>'] = cmp.mapping(function()
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          end
        end, { 'i', 's' }),
      },
      sources = {
        {
          name = 'lazydev',
          -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
          group_index = 0,
        },
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
    }

    -- Setup for commandline
    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline {
        ['<C-y>'] = cmp.mapping.confirm { select = true },
        ['<C-e>'] = cmp.mapping.close(),
      },
      sources = {
        { name = 'buffer' },
      },
    })
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline {
        ['<C-y>'] = cmp.mapping.confirm { select = true },
        ['<C-e>'] = cmp.mapping.close(),
      },
      sources = cmp.config.sources {
        { name = 'path' },
        { name = 'cmdline' },
      },
    })
  end,
}
return M
