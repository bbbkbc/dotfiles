local M = {
  'iamcco/markdown-preview.nvim',
}

M.cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' }
M.ft = { 'markdown' }
M.build = function()
  vim.fn['mkdp#util#install']()
end

return M
