local M = {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
}

M.opts = {
  ensure_installed = {
    'bash',
    'c',
    'html',
    'lua',
    'luadoc',
    'markdown',
    'vim',
    'vimdoc',
    'dockerfile',
    'gitignore',
    'python',
    'yaml',
    'rust',
  },
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = {},
    disable = { 'just' },
  },
  indent = { enable = true, disable = {} },
}
M.config = function(_, opts)
  require('nvim-treesitter.configs').setup(opts)
end

return M
