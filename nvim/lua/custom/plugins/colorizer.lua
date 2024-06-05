local M = {
  'norcalli/nvim-colorizer.lua',
}
M.config = function()
  require('colorizer').setup()
end
return M
