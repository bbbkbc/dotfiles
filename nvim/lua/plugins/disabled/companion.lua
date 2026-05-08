M = {
  'olimorris/codecompanion.nvim',
  version = '^19.1.0',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
}

M.init = function()
  local cc = require('codecompanion')
  local wk = require('which-key')
  cc.setup({
    interactions = {
      chat = {
        adapter = {
          name = 'ollama',
          model = 'qwen3.5:9b',
          autoload = 'default',
          enabled = true,
        },
      },
    },
    opts = {
      log_level = 'info',
      completion_provider = 'cmp',
      language = 'Polish',
    },
  })
  wk.add({
    { '<leader>cc', '<cmd>CodeCompanion<CR>', desc = 'Toggle Code Companion', mode = 'n' },
    { '<leader>cd', '<cmd>CodeCompanionChat<CR>', desc = 'Toggle Chat', mode = 'n' },
  })
end

return M
