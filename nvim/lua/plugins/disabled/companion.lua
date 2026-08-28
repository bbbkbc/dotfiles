M = {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
}

M.config = function()
  local cc = require('codecompanion')
  local wk = require('which-key')
  cc.setup({
    strategies = {
      inline = {
        adapter = 'ollama',
      },
    },
    adapters = {
      ollama = function()
        return require('codecompanion.adapters').extend('ollama', {
          schema = {
            model = {
              default = 'qcwind/qwen3-8b-instruct-Q4-K-M',
            },
          },
        })
      end,
    },
    display = {
      inline = {
        layout = 'vertical',
      },
    },
  })
  wk.add({
    { '<leader>cc', '<cmd>CodeCompanion<CR>', desc = 'Toggle Code Companion', mode = 'n' },
    { '<leader>cd', '<cmd>CodeCompanionChat<CR>', desc = 'Toggle Chat', mode = 'n' },
  })
end

return M
