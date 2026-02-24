local M = {
  'yetone/avante.nvim',
  event = 'VeryLazy',
  version = false, -- Never set this value to "*"! Never!
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    --- The below dependencies are optional,
    'hrsh7th/nvim-cmp', -- autocompletion for avante commands and mentions
    'folke/snacks.nvim', -- for input provider snacks
    'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
    {
      -- support for image pasting
      'HakonHarnes/img-clip.nvim',
      event = 'VeryLazy',
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { 'markdown', 'Avante' },
      },
      ft = { 'markdown', 'Avante' },
    },
  },
}

M.opts = {
  instructions_file = 'avante.md',
  provider = 'ollama',
  auto_detect = false,
  debug = true,

  providers = {
    ollama = {
      endpoint = 'http://127.0.0.1:11434',
      timeout = 30000, -- Timeout in milliseconds
      extra_request_body = {
        options = {
          temperature = 0.75,
          num_ctx = 20480,
          keep_alive = '5m',
        },
      },
    },
    -- ollama = {
    --   __inherited_from = 'openai',
    --   api_key_name = '',
    --   endpoint = 'http://127.0.0.1:11434/v1',
    --   model = 'deepseek-coder-v2:16b',
    --   -- is_env_set = require('avante.providers.ollama').check_endpoint_alive,
    -- },
  },
}

return M
