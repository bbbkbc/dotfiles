local M = {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  version = '*',
  event = 'VeryLazy',
}

function M.config()
  local wk = require 'which-key'
  wk.register {
    ['<leader>e'] = { '<cmd>NvimTreeToggle<CR>', 'Explorer' },
    ['<leader>f'] = { '<cmd>NvimTreeFocus<CR>', 'FocusExplorer' },
  }
  require('nvim-tree').setup {
    hijack_netrw = false,
  }
end
return M
