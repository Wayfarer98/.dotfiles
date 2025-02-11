-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup(
    'kickstart-highlight-yank',
    { clear = true }
  ),
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
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = '*.fs,*.fsx,*.fsi',
  command = [[set filetype=fsharp]],
})

-- Set correct filetype for ispc files
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = '*.ispc',
  callback = function()
    vim.cmd [[set filetype=ispc]]
    vim.cmd [[setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab commentstring=//%s]]
  end,
})

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = '*.c,*.cpp,*.h,*.hpp',
  callback = function()
    vim.cmd [[setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab commentstring=//%s]]
  end,
})

-- Close floating window with Esc
vim.api.nvim_create_autocmd('BufWinEnter', {
  pattern = '*',
  callback = function()
    if vim.api.nvim_win_get_config(0).relative ~= '' then
      vim.api.nvim_buf_set_keymap(
        0,
        'n',
        '<Esc>',
        '<cmd>close<CR>',
        { noremap = true, silent = true, nowait = true }
      )
    end
  end,
})
