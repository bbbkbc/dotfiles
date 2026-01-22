local M = {
  'folke/which-key.nvim',
  event = 'VeryLazy',
}
M.opts = {
  plugins = {
    spelling = {
      enabled = true,
      suggestions = 40,
    },
  },
  -- window = {
  -- border = 'rounded',
  -- },
}
M.keys = {
  {
    '<leader>?',
    function()
      require('which-key').show { global = false }
    end,
    desc = 'Buffer Local Keymaps (which-key)',
  },
}
return M
