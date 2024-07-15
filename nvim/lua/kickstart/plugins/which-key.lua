local M = {
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
}

function M.config()
  local which_key = require 'which-key'
  which_key.setup {
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
    -- window = {
    --   border = 'rounded',
    --   position = 'bottom',
    --   padding = { 2, 2, 2, 2 },
    -- },
    -- ignore_missing = true,
    show_help = false,
    show_keys = false,
    disable = {
      buftypes = {},
      filetypes = { 'TelescopePrompt' },
    },
  }
  -- which_key.add {
  --
  --   ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
  --   ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
  --   ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
  --   ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
  --   ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
  -- }
end

return M
-- vim: ts=2 sts=2 sw=2 et
