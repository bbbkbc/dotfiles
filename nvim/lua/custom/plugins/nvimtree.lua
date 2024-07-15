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
  local icons = require 'custom.addons.icons'
  wk.add {
    { '<leader>T', '<cmd>NvimTreeToggle<CR>', desc = '[E]xplorer', mode = 'n', icon = icons.ui.Folder },
    { '<leader>F', '<cmd>NvimTreeFocus<CR>', desc = '[F]ocusExplorer', mode = 'n', icon = icons.ui.FolderOpen },
  }
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
