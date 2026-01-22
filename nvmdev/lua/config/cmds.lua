-- Generaly i Keep here command which not require any third party plugins

vim.api.nvim_create_user_command('Reload', function(opts)
  local m = opts.args
  package.loaded[m] = nil
  require(m)
end, { nargs = 1 })
