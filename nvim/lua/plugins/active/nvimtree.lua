local M = {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  version = '*',
  event = 'VeryLazy',
}

function M.config()
  local wk = require('which-key')
  local icons = require('addons.icons')
  wk.add({
    { '<leader>T', '<cmd>NvimTreeToggle<CR>', desc = '[T]oggle Explorer', mode = 'n', icon = icons.ui.Folder },
    { '<leader>F', '<cmd>NvimTreeFocus<CR>', desc = '[F]ocus Explorer', mode = 'n', icon = icons.ui.FolderOpen },
  })
  require('nvim-tree').setup({
    hijack_netrw = false,
    filters = {
      dotfiles = true, -- Show dotfiles if you want
      custom = {}, -- Ensure no custom filters are applied
      exclude = {}, -- Make sure no specific exclusions are applied
    },
  })

  -- Auto close nvim-tree if it's the last window open
  vim.api.nvim_create_autocmd('BufEnter', {
    nested = true,
    callback = function()
      -- ile jest okien
      local wins = vim.api.nvim_list_wins()

      -- jeśli jest tylko jedno okno i jego filetype to NvimTree → quit
      if #wins == 1 and vim.bo.filetype == 'NvimTree' then
        vim.cmd('quit')
      end
    end,
  })
end
return M
