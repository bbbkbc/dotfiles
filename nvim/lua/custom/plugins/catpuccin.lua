local M = {
  'catppuccin/nvim',
  name = 'catppuccin',
  -- priority = 1000,
}

function M.init()
  vim.cmd.colorscheme 'catppuccin-macchiato'
  vim.cmd.hi 'Comment gui=none'
end

return M
