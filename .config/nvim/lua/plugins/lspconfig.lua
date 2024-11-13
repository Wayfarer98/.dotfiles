local M = { -- LSP Configuration & Plugins
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Automatically install LSPs and related tools to stdpath for Neovim
    { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',

    -- Useful status updates for LSP.
    -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
    {
      'j-hui/fidget.nvim',
      opts = {},
      config = function()
        require('fidget').setup {
          progress = {
            suppress_on_insert = true,
            ignore_done_already = true,
            ignore_empty_message = true,
          },
          notification = {
            window = {
              winblend = 0,
            },
          },
        }
      end,
    },

    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    {
      'folke/lazydev.nvim',
      ft = 'lua',
      opts = {
        library = {
          -- Load luvit types when the `vim.uv` word is found
          { path = 'luvit-meta/library', words = { 'vim%.uv' } },
        },
      },
    },
    { 'Bilal2453/luvit-meta', lazy = true },
  },
  config = function()
    --  This function gets run when an LSP attaches to a particular buffer.
    --    That is to say, every time a new file is opened that is associated with
    --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
    --    function will be executed to configure the current buffer
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup(
        'kickstart-lsp-attach',
        { clear = true }
      ),
      callback = function(event)
        -- In this case, we create a function that lets us more easily define mappings specific
        -- for LSP related items. It sets the mode, buffer and description for us each time.
        local map = function(keys, func, desc)
          vim.keymap.set(
            'n',
            keys,
            func,
            { buffer = event.buf, desc = 'LSP: ' .. desc }
          )
        end

        -- Jump to the definition of the word under your cursor.
        --  This is where a variable was first declared, or where a function is defined, etc.
        --  To jump back, press <C-t>.
        map(
          'gd',
          require('telescope.builtin').lsp_definitions,
          '[G]oto [D]efinition'
        )

        -- Find references for the word under your cursor.
        map(
          'gr',
          require('telescope.builtin').lsp_references,
          '[G]oto [R]eferences'
        )

        -- Jump to the implementation of the word under your cursor.
        --  Useful when your language has ways of declaring types without an actual implementation.
        map(
          'gI',
          require('telescope.builtin').lsp_implementations,
          '[G]oto [I]mplementation'
        )

        -- Jump to the type of the word under your cursor.
        --  Useful when you're not sure what type a variable is and you want to see
        --  the definition of its *type*, not where it was *defined*.
        map(
          '<leader>D',
          require('telescope.builtin').lsp_type_definitions,
          'Type [D]efinition'
        )

        -- Fuzzy find all the symbols in your current document.
        --  Symbols are things like variables, functions, types, etc.
        map(
          '<leader>ds',
          require('telescope.builtin').lsp_document_symbols,
          '[D]ocument [S]ymbols'
        )

        -- Fuzzy find all the symbols in your current workspace.
        --  Similar to document symbols, except searches over your entire project.
        map(
          '<leader>ws',
          require('telescope.builtin').lsp_dynamic_workspace_symbols,
          '[W]orkspace [S]ymbols'
        )

        -- Rename the variable under your cursor.
        --  Most Language Servers support renaming across files, etc.
        map('<F2>', vim.lsp.buf.rename, 'Rename')

        -- Execute a code action, usually your cursor needs to be on top of an error
        -- or a suggestion from your LSP for this to activate.
        map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        map('[d', function()
          vim.diagnostic.jump { count = -1, float = { border = 'rounded' } }
        end, 'Jump to Previous Diagnostic')

        map(']d', function()
          vim.diagnostic.jump { count = 1, float = { border = 'rounded' } }
        end, 'Jump to Previous Diagnostic')

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if
          client
          and client.supports_method(
            vim.lsp.protocol.Methods.textDocument_documentHighlight
          )
        then
          local highlight_augroup = vim.api.nvim_create_augroup(
            'kickstart-lsp-highlight',
            { clear = false }
          )
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd('CursorHold', {
            buffer = event.buf,
            group = highlight_augroup,
            callback = function()
              for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
                if vim.api.nvim_win_get_config(winid).zindex then
                  return
                end
              end
              local opts = {
                focusable = false,
                close_events = {
                  'BufLeave',
                  'CursorMoved',
                  'InsertEnter',
                  'FocusLost',
                },
                border = 'rounded',
                source = 'always',
                prefix = '',
                scope = 'cursor',
              }
              vim.diagnostic.open_float(nil, opts)
            end,
          })

          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup(
              'kickstart-lsp-detach',
              { clear = true }
            ),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds {
                group = 'kickstart-lsp-highlight',
                buffer = event2.buf,
              }
            end,
          })
        end

        -- This may be unwanted, since they displace some of your code
        if
          client
          and client.supports_method(
            vim.lsp.protocol.Methods.textDocument_inlayHint
          )
        then
          map('<leader>th', function()
            vim.lsp.inlay_hint.enable(
              not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }
            )
          end, '[T]oggle Inlay [H]ints')
        end

        -- Change hover float to have borders
        vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
          vim.lsp.handlers.hover,
          { border = 'rounded', focusable = false }
        )
        vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
          vim.lsp.handlers.signature_help,
          { border = 'rounded', focusable = false }
        )
      end,
    })

    -- LSP servers and clients are able to communicate to each other what features they support.
    --  By default, Neovim doesn't support everything that is in the LSP specification.
    --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
    --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend(
      'force',
      capabilities,
      require('cmp_nvim_lsp').default_capabilities()
    )

    -- Enable the following language servers
    local servers = {
      -- clangd = {},
      -- gopls = {},
      -- pyright = {},
      -- rust_analyzer = {},
      -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
      --
      -- Some languages (like typescript) have entire language plugins that can be useful:
      --    https://github.com/pmizio/typescript-tools.nvim
      --
      ts_ls = {}, -- TypeScript LSP
      cssls = {}, -- CSS LSP
      html = {}, -- HTML LSP
      jsonls = {}, -- JSON LSP
      hls = {}, -- Haskell LSP
      lua_ls = {}, -- Lua LSP
      marksman = {}, -- Markdown LSP
      pyright = {}, -- Python LSP
    }

    -- Ensure the servers and tools above are installed
    require('mason').setup()

    -- You can add other tools here that you want Mason to install
    -- for you, so that they are available from within Neovim.
    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      'stylua', -- Lua Formatter
      'fantomas', -- F# Formatter
      'ormolu', -- Haskell Formatter
      'hlint', -- Haskell Linter
      'markdownlint', -- Markdown Linter
      'prettierd', -- Formatter { Markdown, }
      'isort', -- Python Formatter
      'black', -- Python Formatter
      'ruff', -- Pythong Linter
    })
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    require('mason-lspconfig').setup {
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          -- This handles overriding only values explicitly passed
          -- by the server configuration above. Useful when disabling
          -- certain features of an LSP (for example, turning off formatting for tsserver)
          server.capabilities = vim.tbl_deep_extend(
            'force',
            {},
            capabilities,
            server.capabilities or {}
          )
          require('lspconfig')[server_name].setup(server)
        end,
      },
    }

    -- Setup cool lsp signs
    local signs = {
      Error = '',
      Warn = '',
      Hint = '',
      Information = '',
    }

    vim.diagnostic.config {
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = signs.Error,
          [vim.diagnostic.severity.WARN] = signs.Warn,
          [vim.diagnostic.severity.INFO] = signs.Information,
          [vim.diagnostic.severity.HINT] = signs.Hint,
        },
      },
    }
  end,
}
return M
