local M = {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
}

-- Configuration options
M.config = {
  indent = { enabled = true },
  scroll = { enabled = true },
  statuscolumn = { enabled = true },
}

-- Key mappings
M.keys = {
  -- Buffdelete
  {
    '<leader>Sd',
    function()
      Snacks.bufdelete()
    end,
    desc = 'Delete Buffer',
  },
  -- Lazygit
  {
    '<leader>Sg',
    function()
      Snacks.lazygit()
    end,
    desc = 'Lazygit',
  },
}

-- Initialization function
M.init = function()
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
      Snacks.toggle.option('spell', { name = 'Spelling' }):map '<leader>us'
      Snacks.toggle.option('wrap', { name = 'Wrap' }):map '<leader>uw'
      Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map '<leader>uL'
      Snacks.toggle.diagnostics():map '<leader>ud'
      Snacks.toggle.line_number():map '<leader>ul'
      Snacks.toggle.option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map '<leader>uc'
      Snacks.toggle.inlay_hints():map '<leader>uh'
      Snacks.toggle.indent():map '<leader>ug'
      Snacks.toggle.dim():map '<leader>uD'
    end,
  })
end

return M
