local M = {
  'iamcco/markdown-preview.nvim',
}

M.cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' }
M.ft = { 'markdown' }
M.build = function()
  vim.fn['mkdp#util#install']()
end
M.config = function()
  vim.g.mkdp_auto_start = 0
  vim.g.mkdp_auto_close = 0
  vim.g.mkdp_auto_open = 0
  vim.g.mkdp_browser = 'chromium'
  vim.g.mkdp_refresh_slow = 0
  vim.g.mkdp_refresh_on_save = 0
end

return M
