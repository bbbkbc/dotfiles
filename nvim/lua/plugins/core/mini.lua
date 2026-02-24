local M = {
  'echasnovski/mini.nvim',
}

function M.config()
  -- INFO: MINI:
  --  - va)  - [V]isually select [A]round [)]paren
  --  - yinq - [Y]ank [I]nside [N]ext [']quote
  --  - ci'  - [C]hange [I]nside [']quote
  Ai = require('mini.ai')
  Ai.setup({ n_lines = 500 })

  -- INFO: Surround
  -- Add/delete/replace surroundings (brackets, quotes, etc.)
  -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
  -- - sd'   - [S]urround [D]elete [']quotes
  -- - sr)'  - [S]urround [R]eplace [)] [']
  Surround = require('mini.surround')
  Surround.setup()

  StatusLine = require('mini.statusline')
  StatusLine.setup({
    use_icons = vim.g.have_nerd_font,
    section_location = function()
      return '%2l:%-2v'
    end,
  })

  -- INFO: Jump
  -- Jump to any character in the current line
  --  f, F, t, T, ;, , - like in Vim
  -- Jump = require('mini.jump')
  -- Jump.setup()

  -- INFO: Pairs - make live easier with pairs of characters
  --  - Insert (), [], {}, '', "", `` etc. in pair
  Pairs = require('mini.pairs')
  Pairs.setup()

  --  Check out: https://github.com/echasnovski/mini.nvim
end

return M
