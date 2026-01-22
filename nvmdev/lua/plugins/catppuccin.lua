local M = {
  'catppuccin/nvim',
  name = 'catppuccin',
  -- lazy = true,
  priority = 1000,
  opts = {},
}

function M.init()
  local cat = require 'catppuccin'
  cat.setup {
    transparent_background = false,
    dim_inactive = {
      enabled = true, -- dims the background color of inactive window
      shade = 'dark', -- 'dark' | 'light' | 'gray'
      percentage = 0.15, -- percentage of the shade to apply to the inactive window
    },
  }
  -- Set the colorscheme
  vim.cmd.colorscheme 'catppuccin-macchiato'
  vim.cmd.hi 'Comment gui=none'
end

return M
