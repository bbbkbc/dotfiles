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
  vim.api.nvim_create_autocmd('LspAttach', {

    group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
    callback = function(event)
      local map = function(keys, func, desc, mode)
        mode = mode or 'n'
        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
      end

      map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
      map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
      map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
      map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
      map('<leader>ls', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
      map('<leader>lw', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace Symbols')
      map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
      map('<leader>la', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
      map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

      local function client_supports_method(client, method, bufnr)
        if vim.fn.has 'nvim-0.11' == 1 then
          return client.supports_method(method, bufnr)
        else
          return client.supports_method(method, { bufnr = bufnr })
        end
      end

      local client = vim.lsp.get_client_by_id(event.data.client_id)

      if client and client.name == 'ruff' then
        client.server_capabilities.hoverProvider = false
      end

      if client and client.name == 'llm' then
        client.offset_encoding = 'utf-16'
      end

      if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
        local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
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
          group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
          callback = function(event2)
            vim.lsp.buf.clear_references()
            vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
          end,
        })
      end

      -- The following code creates a keymap to toggle inlay hints in your
      -- code, if the language server you are using supports them
      --
      -- This may be unwanted, since they displace some of your code
      if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
        map('<leader>th', function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
        end, '[T]oggle Inlay [H]ints')
      end
    end,
  })

  -- Diagnostic Config
  -- See :help vim.diagnostic.Opts
  vim.diagnostic.config {
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
  }

  -- LSP servers and clients are able to communicate to each other what features they support.
  --  By default, Neovim doesn't support everything that is in the LSP specification.
  --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
  --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

  -- Enable the following language servers
  local servers = {
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
    -- basedpyright = {},
    pyright = {},
    -- ty = {},
    ruff = {
      init_options = {
        settings = {
          logLevel = 'debug',
        },
      },
    },
    ansiblels = {
      filetypes = { 'yaml.ansible' },
      settings = {
        ansible = {
          path = 'ansible',
          useFullyQualifiedCollectionNames = true,
          ansibleLint = {
            enabled = true,
          },
          python = {
            interpreterPath = 'python',
          },
          completion = {
            provideModuleOptionsAliases = true,
            provideRedirectModule = true,
          },
        },
      },
    },
    jsonls = {},
    marksman = {},
    dockerls = {},
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
    'taplo',
    'yamlfmt',
    'markdownlint',
  })

  require('mason-tool-installer').setup { ensure_installed = ensure_installed }

  require('mason-lspconfig').setup {
    ensure_installed = {},
    automatic_installation = false,
  }
end

return M
