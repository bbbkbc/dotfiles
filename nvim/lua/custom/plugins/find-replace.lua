local M = {
  'bbbkbc/find-replace.nvim',
  config = function()
    vim.keymap.set('n', '<leader>fr', require('find_replace').find_and_replace_in_buffer)
  end,
}

return M
