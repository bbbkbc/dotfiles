local M = {
  -- 'catppuccin/nvim',
  'folke/tokyonight.nvim',
  lazy = true,
  priority = 1000,
  opts = {},
}

function M.init()
  -- vim.cmd.colorscheme 'catppuccin-macchiato'
  vim.cmd.colorscheme 'tokyonight-storm'
  -- vim.cmd.hi 'Comment gui=none'
end

return M
