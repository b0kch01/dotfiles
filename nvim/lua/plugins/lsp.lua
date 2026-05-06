return {
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    'mason-org/mason.nvim',
  },
  {
    'neovim/nvim-lspconfig',
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = { 'mason-org/mason.nvim' },
  },
  {
    'mason-org/mason-lspconfig.nvim',
    dependencies = {
      'mason-org/mason.nvim',
      'neovim/nvim-lspconfig',
    },
    init = function()
      require('mason').setup()

      require('mason-tool-installer').setup({
        ensure_installed = {
          'stylua',
          'lua_ls',
          'vtsls',
          'jsonls',
          'eslint-lsp',
          'eslint_d',
          'biome',
          'prettierd',
        },
      })

      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = {
              globals = {
                'vim',
                'wait',
              },
            },
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME,
              },
            },
            telemetry = { enable = false },
          },
        },
      })

      require('mason-lspconfig').setup({
        automatic_enable = {
          exclude = { 'lua_ls' },
        },
      })

      vim.lsp.enable('lua_ls')

      vim.diagnostic.config({
        severity_sort = true,
        update_in_insert = false,
        float = {
          border = 'rounded',
          source = 'if_many',
        },
        underline = true,
        virtual_text = {
          spacing = 2,
          source = 'if_many',
          prefix = '●',
        },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅙',
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.INFO] = '',
            [vim.diagnostic.severity.HINT] = '',
          },
        },
      })

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local bufnr = args.buf
          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
          end

          vim.lsp.completion.enable(true, args.data.client_id, args.buf)

          map('n', 'K', vim.lsp.buf.hover, 'LSP Hover')
          map('n', 'gd', vim.lsp.buf.definition, 'Go to definition')
          map('n', 'gD', vim.lsp.buf.declaration, 'Go to declaration')
          map('n', 'gi', vim.lsp.buf.implementation, 'Go to implementation')
          map('n', 'gr', vim.lsp.buf.references, 'References')
          map('n', '<leader>rn', vim.lsp.buf.rename, 'Rename symbol')
          map({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, 'Code action')
          map('n', '<leader>f', function()
            require('conform').format({ bufnr = args.buf })
          end, 'Format buffer')

          local lsp_action = function(action)
            return function()
              vim.lsp.buf.code_action({
                context = { only = { action }, diagnostics = {} },
                apply = true,
              })
            end
          end

          map('n', '<leader>oi', lsp_action('source.organizeImports'), '[O]rganize [I]mports')
          map('n', '<leader>am', lsp_action('source.addMissingImports'), '[A]dd [M]issing Imports')
        end,
      })
    end,
  },
}
