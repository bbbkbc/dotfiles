local M = {
  'folke/snacks.nvim',
  dependencies = {},
  priority = 1000,
  lazy = false,
}

-- Configuration options
M.opts = {
  bigfile = { enabled = true },
  dashboard = { enabled = true },
  indent = { enabled = true },
  picker = { enabled = true },
  scroll = { enabled = true },
  statuscolumn = { enabled = true },
  image = { enabled = true },
  words = { enabled = true },
  notifier = {
    padding = true,
    top_down = false,
    style = 'compact',
    margin = { top = 0, right = 0, bottom = 1 },
  },
  styles = {
    notification = {
      wo = { wrap = true }, -- Wrap notifications
    },
  },
}

-- Initialization function
M.init = function()
  local Snacks = require('snacks')
  -- maybe replace with Snacks.explorer later
  -- keys.set('n', '<leader>F', function()
  --   Snacks.explorer()
  -- end, { desc = '[F]ile Explorer' })

  -- Lazy-load some functionality on VeryLazy event
  vim.api.nvim_create_autocmd('User', {
    pattern = 'VeryLazy',
    desc = 'Snacks Toggle',
    callback = function()
      -- Setup some globals for debugging (lazy-loaded)
      _G.dd = function(...)
        Snacks.debug.inspect(...)
      end
      _G.bt = function()
        Snacks.debug.backtrace()
      end
      vim.print = _G.dd -- Override print to use snacks for `:=` command

      -- Create some toggle mappings
      Snacks.toggle.option('spell', { name = 'Spelling' }):map('<leader>Sus')
      Snacks.toggle.option('wrap', { name = 'Wrap' }):map('<leader>Suw')
      Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map('<leader>SuL')
      Snacks.toggle.diagnostics():map('<leader>Sud')
      Snacks.toggle.line_number():map('<leader>Sul')
      Snacks.toggle
        .option('conceallevel', {
          off = 0,
          on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2,
        })
        :map('<leader>Suc')
      Snacks.toggle.inlay_hints():map('<leader>Suh')
      Snacks.toggle.indent():map('<leader>Sug')
      Snacks.toggle.dim():map('<leader>SuD')
    end,
  })
end

Pick = require('addons.utils').pick
-- Key mappings for Snacks pickers replacing telescope builtins
-- find --
vim.keymap.set('n', '<leader><leader>', Pick('buffers'), { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>nn', Pick('notifications'), { desc = 'Show [N]otifications' })
vim.keymap.set('n', '<leader>sf', Pick('files'), { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sn', Pick('files', { cwd = vim.fn.stdpath('config') }), { desc = '[S]earch [N]eovim files' })
vim.keymap.set('n', '<leader>ss', Pick('commands'), { desc = '[S]earch Commands' })
-- search --
vim.keymap.set('n', '<leader>sh', Pick('help'), { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sk', Pick('keymaps'), { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>sd', Pick('diagnostics'), { desc = '[S]earch [D]iagnostics' })
-- grep --
vim.keymap.set('n', '<leader>sw', Pick('grep_word'), { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>s/', Pick('grep_buffers'), { desc = '[S]earch [/] in Open Buffers' })
vim.keymap.set('n', '<leader>/', Pick('lines'), { desc = '[S]earch [/] in current buffer' })
vim.keymap.set('n', '<leader>s.', Pick('recent'), { desc = '[S]earch Recent Files' })
-- git --
vim.keymap.set('n', '<leader>gb', Pick('git_branches'), { desc = '[G]it [B]ranches' })
vim.keymap.set('n', '<leader>gd', Pick('git_diff'), { desc = '[G]it [D]iffs' })
vim.keymap.set('n', '<leader>gs', Pick('git_status'), { desc = '[G]it [S]tatus' })
vim.keymap.set('n', '<leader>gL', function()
  require('snacks').lazygit()
end, { desc = '[G]it [L]azygit' })
-- maybe replace with Snacks.explorer later
-- keys.set('n', '<leader>F', function()
--   Snacks.explorer()
-- end, { desc = '[F]ile Explorer' })

return M
