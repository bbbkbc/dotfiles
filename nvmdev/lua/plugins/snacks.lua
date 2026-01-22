local M = {
  'folke/snacks.nvim',
  dependencies = {},
  priority = 1000,
  lazy = false,
}

-- Configuration options
M.opts = {
  dashboard = { enabled = true },
  indent = { enabled = true },
  picker = { enabled = true },
  scroll = { enabled = true },
  statuscolumn = { enabled = true },
  image = { enabled = true },
}

M.opts.statuscolumn = {
  left = { 'mark', 'sign' }, -- priority of signs on the left (high to low)
  right = { 'fold', 'git' }, -- priority of signs on the right (high to low)
  folds = {
    open = false, -- show open fold icons
    git_hl = false, -- use Git Signs hl for fold icons
  },
  git = {
    -- patterns to match Git signs
    patterns = { 'GitSign', 'MiniDiffSign' },
  },
  refresh = 50, -- refresh at most every 50ms
}

local sm = require('config.utils')

vim.keymap.set('n', '<leader><leader>', sm.pick('buffers'), { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>sf', sm.pick('files'), { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', sm.pick('help'), { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sk', sm.pick('keymaps'), { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>/', sm.pick('grep_buffers'), { desc = '[S]earch grep in open buffers' })

-- Initialization function
M.init = function()
  local Snacks = require('snacks')

  local keys = Snacks.keymap
  keys.set('n', '<leader>Sr', function()
    Snacks.reload_config()
  end, { desc = 'Reload Config' })
  keys.set('n', '<leader>Sd', function()
    Snacks.bufdelete()
  end, { desc = 'Delete Buffer' })
  keys.set('n', '<leader>Sg', function()
    Snacks.lazygit()
  end, { desc = 'Lazygit' })

  keys.set('n', '<leader>T', function()
    Snacks.explorer()
  end, { desc = '[T]oggle Explorer' })

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
      Snacks.toggle.option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map('<leader>Suc')
      Snacks.toggle.inlay_hints():map('<leader>Suh')
      Snacks.toggle.indent():map('<leader>Sug')
      Snacks.toggle.dim():map('<leader>SuD')
    end,
  })
end

return M
