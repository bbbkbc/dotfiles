local M = {
  -- LSP Configuration & Plugins
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Automatically install LSPs and related tools to stdpath for Neovim
    { 'williamboman/mason.nvim', opts = {} },
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',

    -- Useful status updates for LSP.
    { 'j-hui/fidget.nvim', opts = {} },
    { 'folke/neodev.nvim', opts = {} },

    'hrsh7th/cmp-nvim-lsp',
    -- 'saghen/blink.cmp',
  },
}

function M.config()
  Pick = require('addons.utils').pick

  -- LSP Attach Callback
  vim.api.nvim_create_autocmd('LspAttach', {

    group = vim.api.nvim_create_augroup('lsp_attach', { clear = true }),

    callback = function(event)
      local map = function(keys, func, desc, mode)
        mode = mode or 'n'
        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
      end

      map('gd', Pick('lsp_definitions'), '[G]oto [D]efinition')
      map('gr', Pick('lsp_references'), '[G]oto [R]eferences')
      map('gI', Pick('lsp_implementations'), '[G]oto [I]mplementation')
      map('<leader>D', Pick('lsp_type_definitions'), 'Type [D]efinition')
      map('<leader>ls', Pick('lsp_symbols'), '[D]ocument [S]ymbols')
      map('<leader>lw', Pick('lsp_workspace_symbols'), '[W]orkspace Symbols')
      map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
      map('<leader>la', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
      map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
      --

      local client = vim.lsp.get_client_by_id(event.data.client_id)

      if client == nil then
        return
      end

      -- if client.name == 'pyright' then
      --   client.server_capabilities.hoverProvider = false
      -- end

      if client.name == 'ruff' then
        client.server_capabilities.hoverProvider = false
      end

      if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
        local highlight_augroup = vim.api.nvim_create_augroup('lsp_highlight', { clear = false })
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.clear_references,
        })

        vim.api.nvim_create_autocmd('LspDetach', {
          group = vim.api.nvim_create_augroup('lsp_detach', { clear = true }),
          callback = function(event2)
            vim.lsp.buf.clear_references()
            vim.api.nvim_clear_autocmds({ group = 'lsp_highlight', buffer = event2.buf })
          end,
        })
      end

      -- The following code creates a keymap to toggle inlay hints in your
      -- code, if the language server you are using supports them
      --
      -- This may be unwanted, since they displace some of your code
      if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
        map('<leader>th', function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
        end, '[T]oggle Inlay [H]ints')
      end
    end,
  })

  -- Diagnostic Config
  -- See :help vim.diagnostic.Opts
  vim.diagnostic.config({
    severity_sort = true,
    float = { border = 'rounded', source = 'if_many' },
    underline = { severity = vim.diagnostic.severity.ERROR },
    signs = vim.g.have_nerd_font and {
      text = {
        [vim.diagnostic.severity.ERROR] = '󰅚 ',
        [vim.diagnostic.severity.WARN] = '󰀪 ',
        [vim.diagnostic.severity.INFO] = '󰋽 ',
        [vim.diagnostic.severity.HINT] = '󰌶 ',
      },
    } or {},
    virtual_text = {
      source = 'if_many',
      spacing = 2,
      format = function(diagnostic)
        local diagnostic_message = {
          [vim.diagnostic.severity.ERROR] = diagnostic.message,
          [vim.diagnostic.severity.WARN] = diagnostic.message,
          [vim.diagnostic.severity.INFO] = diagnostic.message,
          [vim.diagnostic.severity.HINT] = diagnostic.message,
        }
        return diagnostic_message[diagnostic.severity]
      end,
    },
  })

  -- LSP servers and clients are able to communicate to each other what features they support.
  --  By default, Neovim doesn't support everything that is in the LSP specification.
  --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
  --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  capabilities.general.positionEncodings = { 'utf-16' }
  capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
  -- Enable the following language servers
  local servers = {
    lua_ls = {
      settings = {
        Lua = {
          runtime = { version = 'LuaJIT' },
          completion = { callSnippet = 'Replace' },
          diagnostics = {
            globals = {
              'vim',
              'require',
            },
          },
          telemetry = { enable = false },
        },
      },
    },
    rust_analyzer = {
      ['rust-analyzer'] = {
        diagnostics = {
          enable = true,
        },
        checkOnSave = {
          command = 'clippy',
        },
      },
    },
    -- python stuff servers and linters
    -- basedpyright = {},
    pyright = {
      settings = {
        additinalProperties = true,
        python = {
          analysis = {
            -- autoSearchPaths = true,
            -- diagnosticMode = 'openFilesOnly',
            useLibraryCodeForTypes = true,
            typeCheckingMode = 'strict', -- "off", "basic", or "strict"
          },
        },
      },
    },
    -- ty = {
    --   settings = {
    --     ty = {
    --       showSyntaxErrors = true,
    --       completions = { autoImport = true },
    --     },
    --   },
    -- },
    ruff = {
      init_options = {
        settings = {
          logLevel = 'info',
        },
      },
    },
    -- json formatter and linter
    jsonls = {},
    -- markdown and servers
    marksman = {},
    -- docker language server
    dockerls = {},
    -- toml and yaml linters and formatters
    yamlfmt = {},
    tombi = {},
  }

  for server, srv in pairs(servers) do
    srv.capabilities = vim.tbl_deep_extend('force', {}, capabilities, srv.capabilities or {})
    vim.lsp.config(server, srv)
  end

  require('mason').setup()

  -- You can add other tools here that you want Mason to install
  local ensure_installed = vim.tbl_keys(servers or {})

  vim.list_extend(ensure_installed, {
    'stylua',
    'just',
    'markdownlint',
  })

  require('mason-tool-installer').setup({ ensure_installed = ensure_installed })

  require('mason-lspconfig').setup({
    ensure_installed = {},
    automatic_installation = false,
  })
end

return M
