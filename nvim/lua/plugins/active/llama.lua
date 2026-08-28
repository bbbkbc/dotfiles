local M = {
  'ggml-org/llama.vim',
  event = 'InsertEnter',
}

function M.init()
  vim.g.llama_config = {
    endpoint_fim = 'http://127.0.0.1:8012/infill',
    -- endpoint_fim = 'http://127.0.0.1:8080/infill',
    n_prefix = 128,
    n_suffix = 32,
    n_predict = 24,
    t_max_predict_ms = 200,
    auto_fim = true,
    ring_n_chunks = 0,
    -- show_info = 1,
    -- delay = 50,
  }
  vim.api.nvim_set_hl(0, 'llama_hl_fim_hint', { fg = '#a5adcb', ctermfg = 209 })
  vim.api.nvim_set_hl(0, 'llama_hl_fim_info', { fg = '#f5a97f', ctermfg = 119 })
end

return M
