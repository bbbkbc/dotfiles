local M = {
  'OXY2DEV/markview.nvim',
  lazy = false,
}

function M.config()
  local wk = require('which-key')
  wk.add({
    { '<leader>m', group = '[M]arkview', desc = 'Markview Commands', icon = '📌' },
    { '<leader>mt', '<cmd>Markview toggle<CR>', desc = '[M]arkview [T]oggle', mode = 'n', icon = '📌' },
    { '<leader>ms', '<cmd>Markview splitToggle<CR>', desc = '[M]arkview [s]plit', mode = 'n', icon = '📌' },
  })
end
return M
