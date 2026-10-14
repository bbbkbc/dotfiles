local M = {
  'OXY2DEV/markview.nvim',
  'kevalin/mermaid.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  lazy = false,
}

function M.config()
  local mmd = require('mermaid')
  mmd.setup({
    lind = { enabled = true },
  })
end

local wk = require('which-key')
wk.add({
  { '<leader>m', group = '[M]arkdownTools', desc = 'Markdown Tools', icon = '📌' },
  { '<leader>mt', '<cmd>Markview toggle<CR>', desc = '[M]arkview [T]oggle', mode = 'n', icon = '📌' },
  { '<leader>ms', '<cmd>Markview splitToggle<CR>', desc = '[M]arkview [s]plit', mode = 'n', icon = '📌' },
  { '<leader>mmp', '<cmd>MermaidPreview<CR>', desc = '[M]mermaid [p]review', mode = 'n', icon = '📌' },
  { '<leader>mms', '<cmd>MermaidPreviewStop<CR>', desc = '[M]ermaid [p]review [s]top', mode = 'n', icon = '📌' },
})
return M
