local M = {
  'vimpostor/vim-tpipeline',
  config = function()
    vim.g.tpiple_autoembed = 0
    vim.g.tpipeline_restore = 1
    vim.g.tpipeline_clearstl = 1
  end,
}
return M
