return {
  'stevearc/conform.nvim',
  dependecies = {
    'mason-org/mason-lspconfig.nvim',
  },
  opts = {
    formatters_by_ft = {
      lua = { 'stylua', stop_after_first = true },
      ['*'] = { 'biome-check', 'eslint_d', 'prettierd', stop_after_first = true },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_format = 'fallback',
    },
  },

  config = function(_, opts)
    require('conform').setup(opts)
  end,
}
