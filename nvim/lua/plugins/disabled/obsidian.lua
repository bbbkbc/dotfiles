local M = {
  'obsidian-nvim/obsidian.nvim',
  version = '*',
  lazy = true,
  ft = 'markdown',
}

M.opts = {
  legacy_commands = false,
  workspaces = {
    { name = 'personal', path = '~/code/vaults/personal' },
    { nmae = 'work', path = '~/code/vaults/work' },
  },
}

return M
