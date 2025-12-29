local M = {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
}

-- Configuration options
M.opts = {
  indent = { enabled = true },
  scroll = { enabled = true },
  statuscolumn = { enabled = true },
}

-- Initialization function
M.init = function()
  local Snacks = require 'snacks'

  Snacks.keymap.set('n', '<leader>Sd', function()
    Snacks.bufdelete()
  end, { desc = 'Delete Buffer' })

  Snacks.keymap.set('n', '<leader>Sg', function()
    Snacks.lazygit()
  end, { desc = 'Lazygit' })

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
      Snacks.toggle.option('spell', { name = 'Spelling' }):map '<leader>Sus'
      Snacks.toggle.option('wrap', { name = 'Wrap' }):map '<leader>Suw'
      Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map '<leader>SuL'
      Snacks.toggle.diagnostics():map '<leader>Sud'
      Snacks.toggle.line_number():map '<leader>Sul'
      Snacks.toggle.option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map '<leader>Suc'
      Snacks.toggle.inlay_hints():map '<leader>Suh'
      Snacks.toggle.indent():map '<leader>Sug'
      Snacks.toggle.dim():map '<leader>SuD'
    end,
  })
end

return M
