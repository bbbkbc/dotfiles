local M = {
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
}

function M.config()
  local mappings = {
    q = { '<cmd>confirm q<CR>', 'Quit' },
    h = { '<cmd>nohlsearch<CR>', 'NOHL' },
    [';'] = { '<cmd>tabnew | terminal<CR>', 'Term' },
    v = { '<cmd>vsplit<CR>', 'Split' },
    b = { name = 'Buffers' },
    d = { name = 'Debug' },
    f = { name = 'Find' },
    g = { name = 'Git' },
    l = { name = 'LSP' },
    p = { name = 'Plugins' },
    t = { name = 'Test' },
    a = {
      name = 'Tab',
      n = { '<cmd>$tabnew<cr>', 'New Empty Tab' },
      N = { '<cmd>tabnew %<cr>', 'New Tab' },
      o = { '<cmd>tabonly<cr>', 'Only' },
      h = { '<cmd>-tabmove<cr>', 'Move Left' },
      l = { '<cmd>+tabmove<cr>', 'Move Right' },
    },
    T = { name = 'Treesitter' },
  }
  local which_key = require 'which-key'
  which_key.setup {
    plugins = {
      marks = true,
      registers = true,
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
    window = {
      border = 'rounded',
      position = 'bottom',
      padding = { 2, 2, 2, 2 },
    },
    ignore_missing = true,
    show_help = false,
    show_keys = false,
    disable = {
      buftypes = {},
      filetypes = { 'TelescopePrompt' },
    },
  }
  which_key.register {
    ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
    ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
    ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
    ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
    ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
  }
end

return M
-- vim: ts=2 sts=2 sw=2 et
