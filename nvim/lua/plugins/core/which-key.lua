local M = {
  'folke/which-key.nvim',
  -- event = 'VeryLazy', -- Sets the loading event to 'VimEnter'
}

function M.config()
  local wk = require('which-key')
  wk.setup({
    preset = 'classic',
    delay = 0,
    plugins = {
      marks = true,
      -- registers = true,
      spelling = {
        enabled = true,
        suggestions = 20,
      },
      presets = {
        operators = false,
        motions = false,
        text_objects = false,
        windows = false,
        nav = false,
        z = false,
        g = false,
      },
    },
    sort = { 'alphanum' },
    icons = {
      breadcrumb = '»',
      separator = '➜',
      group = '',
    },
    show_help = false,
    show_keys = false,
    disable = {
      buftypes = {},
    },
  })
  wk.add({
    { '<leader>s', group = '[s]earch', desc = 'Search Commands', icon = '🔍' },
    { '<leader>S', group = '[S]nacks', desc = '[S]nacks Commands', icon = '🍿' },
    { '<leader>l', group = '[L]sp secondary actions', icon = '⚙️' },
    { '<leader>g', group = '[G]it utilities', icon = '' },
    { '<leader>n', group = '[N]otifications', desc = 'Show Notifications', icon = '💡' },
    { '<leader>r', group = '[R]enames', desc = 'Rename stuff', icon = '📝' },
    { '<leader>d', group = '[D]ebugger', desc = '[D]ebugger', icon = '🐞' },
    { '<leader>m', group = '[M]markdowns', desc = '[M]markdowns tools', icon = '⚙️' },
    -- { '<leader>a', group = '[A]i', desc = '[A]i tools', icon = '🤖' },
  })
end

return M
