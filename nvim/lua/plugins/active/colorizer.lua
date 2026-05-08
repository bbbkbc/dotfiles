-- Color highlighter for Neovim #123
local M = {
  -- 'norcalli/nvim-colorizer.lua',
  'brenoprata10/nvim-highlight-colors',
}

M.init = function()
  require('nvim-highlight-colors').setup()
end
return M
