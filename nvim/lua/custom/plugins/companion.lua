M = {
  'olimorris/codecompanion.nvim',
  version = '18.3.0',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
  },
}

M.config = function()
  local cc = require 'codecompanion'
  local wk = require 'which-key'
  cc.setup {}
  wk.add {
    { '<leader>cc', '<cmd>CodeCompanion<CR>', desc = 'Toggle Code Companion', mode = 'n' },
    { '<leader>cd', '<cmd>CodeCompanionChat<CR>', desc = 'Toggle Chat', mode = 'n' },
  }
end

return M
