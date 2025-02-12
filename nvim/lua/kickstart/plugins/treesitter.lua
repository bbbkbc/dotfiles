local M = {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
}

M.opts = {
  ensure_installed = { 'bash', 'c', 'html', 'lua', 'luadoc', 'markdown', 'vim', 'vimdoc', 'dockerfile', 'gitignore', 'python', 'yaml', 'rust' },
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = {},
  },
  indent = { enable = true, disable = {} },
}
M.config = function(_, opts)
  require('nvim-treesitter.configs').setup(opts)
end

return M
-- vim: ts=2 sts=2 sw=2 et
