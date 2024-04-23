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
      ['e'] = {
        name = '[E]xplorer',
        ['e'] = { '<cmd>NvimTreeToggle<CR>', 'Explorer' },
        ['f'] = { '<cmd>NvimTreeFocus<CR>', 'FocusExplorer' },
      },
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
