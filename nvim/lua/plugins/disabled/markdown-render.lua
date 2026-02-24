local M = {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  ft = { 'markdown' },
  lazy = false,
  opts = {
    html = { comment = { conceal = false } },
  },
}

return M
