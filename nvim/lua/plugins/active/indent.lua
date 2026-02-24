-- Description: Auto-detect and set indentation settings based on the file content
local M = {
  'NMAC427/guess-indent.nvim',
}

M.config = function()
  require('guess-indent').setup({})
end

return M
