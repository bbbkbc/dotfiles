local M = {
  'mfussenegger/nvim-dap',
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',
    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',
    -- Installs the debug adapters for you
    'mason-org/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
    'mfussenegger/nvim-dap-python',
  },
}

M.keys = {
  {
    '<F5>',
    function()
      require('dap').continue()
    end,
    desc = 'Debug: Start/Continue',
  },
  {
    '<F1>',
    function()
      require('dap').step_into()
    end,
    desc = 'Debug: Step Into',
  },
  {
    '<F2>',
    function()
      require('dap').step_over()
    end,
    desc = 'Debug: Step Over',
  },
  {
    '<F3>',
    function()
      require('dap').step_out()
    end,
    desc = 'Debug: Step Out',
  },
  {
    '<leader>b',
    function()
      require('dap').toggle_breakpoint()
    end,
    desc = 'Debug: Toggle Breakpoint',
  },
  {
    '<leader>B',
    function()
      require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end,
    desc = 'Debug: Set Breakpoint',
  },
  -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
  {
    '<F7>',
    function()
      require('dapui').toggle()
    end,
    desc = 'Debug: See last session result.',
  },
}

local function ensure_debugpy_installed()
  local venv_python = '.venv/bin/python'
  if vim.fn.executable(venv_python) == 0 then
    return
  end

  local ok = vim.fn.system {
    venv_python,
    '-c',
    'import debugpy',
  }

  if vim.v.shell_error == 0 then
    return
  end

  vim.notify('Installing debugpy in .venv...', vim.log.levels.INFO)

  vim.fn.system {
    venv_python,
    '-m',
    'pip',
    'install',
    'debugpy',
  }

  if vim.v.shell_error ~= 0 then
    vim.notify('Failed to install debugpy in .venv', vim.log.levels.ERROR)
  else
    vim.notify('debugpy installed in .venv', vim.log.levels.INFO)
  end
end

function M.config()
  local dap = require 'dap'
  local dapui = require 'dapui'

  require('mason-nvim-dap').setup {
    -- Makes a best effort to setup the various debuggers with
    -- reasonable debug configurations
    automatic_installation = true,

    -- You can provide additional configuration to the handlers,
    -- see mason-nvim-dap README for more information
    handlers = {},

    -- You'll need to check that you have the required things installed
    -- online, please don't ask me how to install them :)
    ensure_installed = {
      -- Update this to ensure that you have the debuggers for the langs you want
      'debugpy',
    },
  }

  -- Dap UI setup
  -- For more information, see |:help nvim-dap-ui|
  dapui.setup {
    -- Set icons to characters that are more likely to work in every terminal.
    --    Feel free to remove or use ones that you like more! :)
    --    Don't feel like these are good choices.
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
  }

  -- Change breakpoint icons
  vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e78284' })
  vim.api.nvim_set_hl(0, 'DapStop', { fg = '#e5c890' })
  local breakpoint_icons = vim.g.have_nerd_font
      and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
    or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
  for type, icon in pairs(breakpoint_icons) do
    local tp = 'Dap' .. type
    local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
    vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
  end

  dap.listeners.after.event_initialized['dapui_config'] = dapui.open
  dap.listeners.before.event_terminated['dapui_config'] = dapui.close
  dap.listeners.before.event_exited['dapui_config'] = dapui.close

  -- Python debugging setup
  -- dap.configurations.python = dap.configurations.python or {}
  -- table.insert(dap.configurations.python, {
  --   type = 'python',
  --   request = 'launch',
  --   name = 'typer:args',
  --   program = '${file}',
  --   args = function()
  --     local input = vim.fn.input 'Typer args: '
  --     return vim.split(input, ' ')
  --   end,
  --   console = 'integratedTerminal',
  -- })
  ensure_debugpy_installed()
  require('dap-python').setup '.venv/bin/python'
end

return M
