return {
  -- {
  --   'folke/tokyonight.nvim',
  --   priority = 1000,
  --   opts = {
  --     style = 'night',
  --     transparent = false,
  --   },
  --   config = function(_, opts)
  --     require('tokyonight').setup(opts)
  --     vim.cmd [[colorscheme tokyonight]]
  --   end,
  -- },
  {
    'killitar/obscure.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      transparent = false,
    },
    config = function(_, opts)
      require('obscure').setup(opts)
      vim.cmd [[colorscheme obscure]]
    end,
  },
  --
  -- {
  --   'arzg/vim-colors-xcode',
  --   priority = 1000,
  --   init = function()
  --     vim.cmd.colorscheme 'xcodedarkhc'
  --   end,
  -- },
}
