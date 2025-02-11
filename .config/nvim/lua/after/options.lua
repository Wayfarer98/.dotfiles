-- Flash label color
vim.api.nvim_set_hl(0, 'FlashLabel', { fg = 'red' })

-- Diagnostic colors and underlines
vim.cmd [[
  highlight DiagnosticUnderlineError gui=undercurl
  highlight DiagnosticUnderlineWarn gui=undercurl
  highlight DiagnosticUnderlineInfo gui=undercurl
  highlight DiagnosticUnderlineHint gui=undercurl
  highlight LspSignatureActiveParameter gui=underline
  "highlight! link DiagnosticUnnecessary None ]]
