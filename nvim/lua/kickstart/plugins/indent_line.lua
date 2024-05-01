local M = {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  opts = {},
}

function M.config()
  local highlight = {
    'CursorColumn',
    'Whitespace',
  }
  require('ibl').setup {
    indent = { highlight = highlight, char = '┊' },
    whitespace = {
      -- highlight = highlight,
      remove_blankline_trail = false,
    },
    scope = { enabled = false },
  }
end

return M
