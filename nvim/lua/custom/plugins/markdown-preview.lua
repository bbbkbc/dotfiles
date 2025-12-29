return {
  'iamcco/markdown-preview.nvim',
  ft = { 'markdown' },
  build = function()
    vim.fn['mkdp#util#install']()
  end,

  init = function()
    -- grupa w which-key
    local wk = require 'which-key'
    wk.add {
      { '<leader>m', group = '[M]arkdown Preview', desc = 'Markdown Preview Commands', icon = '📝' },
    }
  end,

  keys = {
    { '<leader>mp', '<cmd>MarkdownPreviewToggle<CR>', desc = 'Toggle Markdown Preview' },
    { '<leader>ms', '<cmd>MarkdownPreviewStop<CR>', desc = 'Stop Markdown Preview' },
    { '<leader>mo', '<cmd>MarkdownPreview<CR>', desc = 'Open Markdown Preview' },
  },
}
