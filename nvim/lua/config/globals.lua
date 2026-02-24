-- Global settings
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- vim.g.netrw_banner = 0
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.have_nerd_font = true

-- Ensure tree-sitter is in the PATH for Neovim
if vim.fn.executable('tree-sitter') == 0 then
  vim.env.PATH = '/usr/bin:' .. (vim.env.PATH or '')
end
