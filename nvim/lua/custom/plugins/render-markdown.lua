local M = {
  -- 'iamcco/markdown-preview.nvim',
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
  ft = { 'markdown' },
  lazy = false,
  opts = {},
}

function M.init()
  vim.api.nvim_set_hl(0, 'RenderMarkdownH1Bg', { bg = '#23273B' })
  vim.api.nvim_set_hl(0, 'RenderMarkdownH2Bg', { bg = '#23273B' })
  vim.api.nvim_set_hl(0, 'RenderMarkdownH3Bg', { bg = '#23273B' })
  vim.api.nvim_set_hl(0, 'RenderMarkdownH4Bg', { bg = '#23273B' })
  vim.api.nvim_set_hl(0, 'RenderMarkdownH5Bg', { bg = '#23273B' })
  vim.api.nvim_set_hl(0, 'RenderMarkdownH6Bg', { bg = '#23273B' })
end

return M
