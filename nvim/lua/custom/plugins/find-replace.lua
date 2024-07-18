local M = {
  'bbbkbc/find-replace.nvim',
  -- branch = 'dev',
}

function M.config()
  local find_replace = require 'find_replace'
  find_replace.setup {
    hl_bg = '#df8e1d',
    hl_fg = '#4c4f60',
  }
  vim.keymap.set('n', '<leader>fr', find_replace.find_and_replace_in_buffer)
end

return M
