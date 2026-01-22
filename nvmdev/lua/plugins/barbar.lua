local M = {
  'romgrk/barbar.nvim',
  version = '^1.0.0', -- optional: only update when a new 1.x version is released
  dependencies = {
    'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
    'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
  },
}

function M.init()
  vim.g.barbar_auto_setup = false
  local barbar = require('barbar')
  local opts = {
    animation = true,
    clickable = false,
    icons = {
      button = '',
      gitsigns = {
        added = { enabled = true, icon = '+' },
        changed = { enabled = true, icon = '~' },
        deleted = { enabled = true, icon = '-' },
      },
      diagnostics = {
        [vim.diagnostic.severity.ERROR] = { enabled = true },
        [vim.diagnostic.severity.WARN] = { enabled = true },
        [vim.diagnostic.severity.INFO] = { enabled = true },
        [vim.diagnostic.severity.HINT] = { enabled = true },
      },
      modified = { button = '●' },
      pinned = { button = '', filename = true },
    },
    -- Sets the maximum padding width with which to surround each tab
    maximum_padding = 1,
    -- Sets the minimum padding width with which to surround each tab
    minimum_padding = 1,
    -- Sets the maximum buffer name length.
    maximum_length = 30,
    -- Sets the minimum buffer name length.
    minimum_length = 0,
    sidebar_filetypes = {
      NvimTree = true,
      -- Or, specify the text used for the offset:
      undotree = {
        text = 'undotree',
        align = 'right', -- *optionally* specify an alignment (either 'left', 'center', or 'right')
      },
    },
  }
  barbar.setup(opts)
end

return M
