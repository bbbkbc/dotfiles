-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

local gr = vim.api.nvim_create_augroup('Autocommands', {})

local opt = vim.opt

local au = function(event, pattern, callback, desc)
  vim.api.nvim_create_autocmd(event, { group = gr, pattern = pattern, callback = callback, desc = desc })
end

-- Auto Highlith on yank(copy)
au('TextYankPost', '*', function()
  vim.highlight.on_yank()
end, 'Highlight on yank')

-- Auto restore terminal cursor when exiting Neovim
au({ 'VimLeave', 'VimSuspend' }, '*', function()
  opt.guicursor = ''
  -- vim.fn.chansend(vim.v.stderr, '\x1b[ q')
end, 'Restore terminal cursor')
