local M = {
  'justinmk/vim-sneak',
}

function M.config()
  vim.keymap.set('n', 'f', '<Plug>Sneak_s', {})
  vim.keymap.set('n', 'F', '<Plug>Sneak_S', {})

  -- Other customization options
  -- vim.g['snea#label'] = 1 -- Enable label mode
  vim.g['sneak#use_ic_scs'] = 1 -- Use ignorecase and smartcase
  vim.g['sneak#absolute_dir'] = 1 -- Respect absolute directions
end

return M
