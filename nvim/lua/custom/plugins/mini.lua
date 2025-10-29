return {
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    lazy = true,
    event = 'VeryLazy',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- Super clean and nice file tree thing
      -- local MiniFiles = require 'mini.files'
      --
      -- MiniFiles.setup {
      --   mappings = {
      --     go_in = '<CR>',
      --     go_in_plus = 'L',
      --     go_out = '-',
      --     go_out_plus = 'H',
      --     close = 'q',
      --   },
      -- }
      -- vim.keymap.set('n', '<leader>e', '<cmd>lua MiniFiles.open()<CR>', {
      --   desc = 'Toggle mini file explorer',
      -- })
    end,
  },
}
