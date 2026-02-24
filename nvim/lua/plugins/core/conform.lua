local M = {
  'stevearc/conform.nvim',
  lazy = false,
}

M.keys = {
  {
    '<leader>4',
    function()
      require('conform').format({ async = true, lsp_fallback = true })
    end,
    mode = '',
    desc = '[F]ormat buffer',
  },
}

M.opts = {
  notify_on_error = false,
  format_on_save = function(bufnr)
    -- Disable "format_on_save lsp_fallback" for languages that don't
    -- have a well standardized coding style. You can add additional
    -- languages here or re-enable it for the disabled ones.
    local disable_filetypes = { c = true, cpp = true }
    return {
      timeout_ms = 500,
      lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
    }
  end,

  formatters_by_ft = {
    lua = { 'stylua' },
    python = { 'ruff_fix', 'ruff_format' },
    rust = { 'rustfmt', lsp_format = 'fallback' },
    just = { 'just' },
    yaml = { 'yamlfmt' },
    -- toml = { 'taplo' },
    -- markdown = { 'markdownlint' },
  },
}

-- vim.api.nvim_create_autocmd('BufWritePre', {
--   pattern = '*',
--   callback = function(args)
--     require('conform').format({ bufnr = args.buf })
--   end,
-- })

return M
