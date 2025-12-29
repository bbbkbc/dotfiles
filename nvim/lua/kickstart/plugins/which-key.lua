local M = {
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
}

function M.config()
  local which_key = require 'which-key'
  which_key.setup {
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
      filetypes = { 'TelescopePrompt' },
    },
  }
  which_key.add {
    {
      '<leader>s',
      group = '[s]earch',
      desc = 'Telescope Commands',
      icon = '🔍',
    },
    {
      '<leader>S',
      group = '[S]nacks',
      desc = '[S]nacks.nvim Commands',
      icon = '🍿',
    },
    {
      '<leader>l',
      group = '[L]sp secondary actions',
      icon = '⚙️',
    },
    {
      '<leader>c',
      group = '[C]ode compannion',
      icon = '🤖',
    },
  }
end

return M
-- vim: ts=2 sts=2 sw=2 et
