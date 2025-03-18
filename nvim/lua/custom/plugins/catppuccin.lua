local M = {
  'catppuccin/nvim',
  name = 'catppuccin',
  -- lazy = true,
  priority = 1000,
  opts = {},
}

function M.init()
  vim.cmd.colorscheme 'catppuccin-macchiato'
  vim.cmd.hi 'Comment gui=none'
end

return M
