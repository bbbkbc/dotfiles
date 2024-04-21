local M = {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
}

function M.config()
  local harpoon = require 'harpoon'
  harpoon:setup()
  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true }
  keymap('n', '<s-m>', function()
    harpoon:list():add()
  end, opts)
  keymap('n', '<TAB>', function()
    harpoon.ui:toggle_quick_menu(harpoon:list())
  end, opts)
end

function M.mark_file()
  require('harpoon.mark').add_file()
  vim.notify '󱡅  marked file'
end

return M
