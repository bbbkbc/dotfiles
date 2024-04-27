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
  local keymap = {
    ['<leader>'] = {
      ['e'] = { '<cmd>NvimTreeToggle<CR>', '[E]xplorer' },
      ['f'] = { '<cmd>NvimTreeFocus<CR>', '[F]ocusExplorer' },
    },
  }
  wk.register { keymap }
  require('nvim-tree').setup {
    hijack_netrw = false,
    filters = {
      dotfiles = true, -- Show dotfiles if you want
      custom = {}, -- Ensure no custom filters are applied
      exclude = {}, -- Make sure no specific exclusions are applied
    },
  }
end
return M
