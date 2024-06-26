local M = {
  'romgrk/barbar.nvim',
  dependencies = {
    'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
    'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
  },
  version = '^1.0.0', -- optional: only update when a new 1.x version is released
}

function M.init()
  vim.g.barbar_auto_setup = false
  local keymap = vim.api.nvim_set_keymap
  local keymap_opts = { noremap = true, silent = true }
  keymap('n', '<A-,>', '<Cmd>BufferPrevious<CR>', keymap_opts)
  keymap('n', '<A-.>', '<Cmd>BufferNext<CR>', keymap_opts)
  keymap('n', '<A-c>', '<Cmd>BufferClose<CR>', keymap_opts)
end

M.opts = {
  animation = true,
  clickable = false,
  icons = {
    button = '',
    gitsigns = {
      added = { enabled = true, icon = '+' },
      changed = { enabled = true, icon = '~' },
      deleted = { enabled = true, icon = '-' },
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
    -- Use the default values: {event = 'BufWinLeave', text = '', align = 'left'}
    NvimTree = true,
    -- Or, specify the text used for the offset:
    undotree = {
      text = 'undotree',
      align = 'right', -- *optionally* specify an alignment (either 'left', 'center', or 'right')
    },
    -- Or, specify the event which the sidebar executes when leaving:
    ['neo-tree'] = { event = 'BufWipeout' },
    -- Or, specify all three
    Outline = { event = 'BufWinLeave', text = 'symbols-outline', align = 'right' },
  },
}

return M
