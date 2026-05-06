return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  init = function()
    local ensuredInstalled = {
      'lua',
      'python',
      'typescript',
      'javascript',
      'json',
      'regex',
      'css',
      'jsx',
      'tsx',
    }

    local alreadyInstalled = require('nvim-treesitter.config').get_installed()
    local parsersToInstall = vim
      .iter(ensuredInstalled)
      :filter(function(parser)
        return not vim.tbl_contains(alreadyInstalled, parser)
      end)
      :totable()

    require('nvim-treesitter').install(parsersToInstall)

    vim.api.nvim_create_autocmd('FileType', {
      pattern = {
        'python',
        'lua',
        'typescript',
        'javascript',
        'javascriptreact',
        'typescriptreact',
        'json',
      },
      callback = function()
        vim.treesitter.start()
      end,
    })
  end,
}
