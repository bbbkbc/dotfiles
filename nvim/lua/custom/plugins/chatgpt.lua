local M = {
  'jackMort/ChatGPT.nvim',
  event = 'VeryLazy',
  config = function()
    require('chatgpt').setup()
  end,
  dependencies = {
    'MunifTanjim/nui.nvim',
    'nvim-lua/plenary.nvim',
    'folke/trouble.nvim',
    'nvim-telescope/telescope.nvim',
  },
}

function M.config()
  local wk = require 'which-key'
  local gpt = require 'chatgpt'
  local keymap = {
    ['<leader>'] = {
      ['g'] = {
        name = '[G]ptChat',
        ['c'] = { '<cmd>ChatGPT<CR>', 'ChatGPT' },
      },
    },
  }
  gpt.setup {
    api_key_cmd = "echo 'OPENAI_API_KEY'",
  }
  wk.register(keymap)
end

return M
