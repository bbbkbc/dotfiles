-- Color highlighter for Neovim #123
local M = {
  'norcalli/nvim-colorizer.lua',
}

M.config = function()
  require('colorizer').setup()
end
return M
