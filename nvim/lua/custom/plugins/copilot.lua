local M = {
  'github/copilot.vim',
  config = function()
    -- Disable Copilot's default <Tab> mapping
    -- vim.g.copilot_no_tab_map = true

    -- Create an autocmd group to manage mappings without duplication
    local copilot_md_group = vim.api.nvim_create_augroup('CopilotMarkdownMapping', { clear = true })

    -- Set up the autocmd for Markdown filetype
    vim.api.nvim_create_autocmd('FileType', {
      group = copilot_md_group,
      pattern = 'markdown',
      callback = function()
        -- Map <C-J> to Copilot's accept function in insert mode
        vim.api.nvim_buf_set_keymap(
          0, -- Buffer number (current buffer)
          'i', -- Insert mode
          '<Home>', -- Key combination: Control + J
          'copilot#Accept()', -- Command to execute
          { expr = true, silent = true, noremap = true }
        )
      end,
    })
  end,
}

return M
