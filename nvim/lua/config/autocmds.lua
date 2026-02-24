-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

local gr = vim.api.nvim_create_augroup('Autocommands', {})

local opt = vim.opt

local cc_by_ft = {
  python = '88',
  rust = '100',
  go = '100',
  lua = '120',
  javascript = '100',
  typescript = '100',
  javascriptreact = '100',
  typescriptreact = '100',
  sh = '100',
  bash = '100',
  zsh = '100',
  yaml = '120',
  json = '120',
  toml = '88',
  just = '100',
  markdown = '100',
}

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

vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function(args)
    local ft = vim.bo[args.buf].filetype
    local cc = cc_by_ft[ft]
    if cc == nil then
      -- Default colorcolumn
      vim.opt_local.colorcolumn = '100'
      return
    end
    vim.opt_local.colorcolumn = cc
  end,
})
