return {
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    opts = {
      style = 'night',
      transparent = false,
    },
    config = function(_, opts)
      require('tokyonight').setup(opts)
      vim.cmd [[colorscheme tokyonight]]
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
