local M = {
  'seblyng/roslyn.nvim',
  ft = 'cs',
  opts = {}, --empty for defaults
}

vim.lsp.config('roslyn', {
  on_attach = function()
    print 'Roslyn LSP attached'
  end,
  settings = {
    ['csharp|inlay_hints'] = {
      csharp_enable_inlay_hints_for_implicit_object_creation = true,
      csharp_enable_inlay_hints_for_implicit_variable_types = true,
    },
    ['csharp|code_lens'] = {
      dotnet_enable_references_code_lens = true,
    },
  },
})

return M
