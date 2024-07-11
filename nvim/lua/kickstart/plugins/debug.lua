local M = {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
    'mfussenegger/nvim-dap-python',
  },
}

local function setup_python_dap(dap)
  -- Adjust PYTHONPATH to include paths to your local libraries
  local function get_python_path()
    local venv_path = vim.fn.system 'poetry env info -p'
    return venv_path:gsub('%s+', '') .. '/bin/python' -- Clean up any trailing whitespace
  end

  local python_path = get_python_path()
  require('dap-python').setup(python_path)

  dap.adapters.python = {
    type = 'executable',
    command = python_path,
    args = { '-m', 'debugpy.adapter' },
  }
  dap.configurations.python = {
    {
      type = 'python',
      request = 'launch',
      name = 'Launch file',
      program = '${file}',
      pythonPath = function()
        return python_path
      end,
      cwd = vim.fn.getcwd() .. '/src',
      env = {
        PYTHONPATH = vim.fn.getcwd() .. '/src', -- Ensure PYTHONPATH is set correctly
      },
    },
  }
end

function M.config()
  local dap = require 'dap'
  local dapui = require 'dapui'
  require('mason-nvim-dap').setup {
    automatic_setup = true,
    handlers = {},
    ensure_installed = {
      'debugpy',
    },
  }
  -- Basic debugging keymaps, feel free to change to your liking!
  vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })
  vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
  vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
  vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
  vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
  vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
  vim.keymap.set('n', '<leader>B', function()
    dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
  end, { desc = 'Debug: Set Breakpoint' })

  dapui.setup {
    icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
    controls = {
      icons = {
        pause = '⏸',
        play = '▶',
        step_into = '⏎',
        step_over = '⏭',
        step_out = '⏮',
        step_back = 'b',
        run_last = '▶▶',
        terminate = '⏹',
        disconnect = '⏏',
      },
    },
    layouts = {
      {
        elements = {
          'scopes',
          'breakpoints',
          'stacks',
          -- 'watches', -- Includes the watches buffer
        },
        size = 40,
        position = 'left',
      },
      {
        elements = {
          'repl',
          -- 'console',
        },
        size = 10,
        position = 'bottom',
      },
    },
  }

  dap.listeners.after.event_initialized['dapui_config'] = dapui.open
  dap.listeners.before.event_terminated['dapui_config'] = dapui.close
  dap.listeners.before.event_exited['dapui_config'] = dapui.close

  -- Setup Python debugging
  setup_python_dap(dap)
end

return M
