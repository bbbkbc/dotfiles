local M = {
  'lewis6991/gitsigns.nvim',
}

function M.config()
  local gitsigns = require('gitsigns')
  gitsigns.setup({
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
  })
end

return M
-- vim: ts=2 sts=2 sw=2 et
