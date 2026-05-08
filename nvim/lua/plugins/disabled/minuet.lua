local M = {
  'milanglacier/minuet-ai.nvim',
}

function M.config()
  local minuet = require('minuet')
  minuet.setup({
    provider = 'openai_fim_compatible',
    n_completions = 1, -- recommend for local model for resource saving
    -- I recommend beginning with a small context window size and incrementally
    -- expanding it, depending on your local computing power. A context window
    -- of 512, serves as an good starting point to estimate your computing
    -- power. Once you have a reliable estimate of your local computing power,
    -- you should adjust the context window to a larger value.
    context_window = 512,
    provider_options = {
      openai_fim_compatible = {
        model = 'qwen2.5-coder:14b',
        name = 'ollama',
        system = 'see [Prompt] section for the default value',
        few_shots = 'see [Prompt] section for the default value',
        chat_input = 'See [Prompt Section for default value]',
        end_point = 'http://localhost:11434/v1/completions',
        api_key = 'TERM',
        stream = true,
        optional = {
          stop = nil,
          max_tokens = 56,
          top_p = 0.9,
        },
      },
    },
  })

  local cmp = require('cmp')
  cmp.setup({
    sources = {
      {
        { name = 'minuet' },
      },
    },
    performance = {
      fetching_timeout = 2000,
    },

    mapping = {
      ['<A-y>'] = require('minuet').make_cmp_map(),
      -- and your other keymappings
    },
  })
end

return M
