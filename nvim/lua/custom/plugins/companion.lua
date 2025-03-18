M = {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
  },
}

M.config = function()
  local codecompanion = require 'codecompanion'
  codecompanion.setup {}
  --   -- adapters = {
  --   --   deepseekr1 = function()
  --   --     return require('codecompanion.adapters').extend('ollama', {
  --   --       name = 'deepseekr1',
  --   --       schema = {
  --   --         model = {
  --   --           default = 'deepseek-r1:32b',
  --   --         },
  --   --       },
  --   --     })
  --   --   end,
  --   -- },
  --   -- strategies = {
  --   --   chat = {
  --   --     adapter = 'deepseekr1',
  --   --   },
  --   --   inline = {
  --   --     adapter = 'deepseekr1',
  --   --   },
  --   --   agent = {
  --   --     adapter = 'deepseekr1',
  --   --   },
  --   -- },

  local whichkey = require 'which-key'
  whichkey.add {
    { '<leader>cc', '<cmd>CodeCompanion<CR>', desc = 'Toggle Code Companion', mode = 'n' },
    { '<leader>cd', '<cmd>CodeCompanionChat<CR>', desc = 'Toggle Chat', mode = 'n' },
  }
end

return M
