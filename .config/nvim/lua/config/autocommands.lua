-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('BufRead', {
  callback = function(ev)
    if vim.bo[ev.buf].buftype == 'quickfix' then
      vim.schedule(function()
        vim.cmd [[cclose]]
        vim.cmd [[Trouble qflist open]]
      end)
    end
  end,
})

-- Set correct filetype for fsharp files
vim.api.nvim_create_autocmd({'BufNewFile','BufRead'}, {
  pattern = '*.fs,*.fsx,*.fsi',
  command = [[set filetype=fsharp]],
})
