return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function(_, opts)
      require('catppuccin').setup(opts)
      vim.cmd [[colorscheme catppuccin]]
    end,
    opts = {
      flavour = 'mocha',
      transparent_background = true,
      float = {
        transparent = true,
        solid = true,
      },
      integerations = {
        cmp = { style = 'bordered' },
        nvimtree = true,
        gitsigns = true,
      },
    },
  },
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
  -- {
  --   'killitar/obscure.nvim',
  --   lazy = false,
  --   priority = 1000,
  --   opts = {
  --     transparent = false,
  --   },
  --   config = function(_, opts)
  --     require('obscure').setup(opts)
  --     vim.cmd [[colorscheme obscure]]
  --   end,
  -- },

  -- {
  --   'arzg/vim-colors-xcode',
  --   priority = 1000,
  --   init = function()
  --     vim.cmd.colorscheme 'xcodedarkhc'
  --   end,
  -- },
  -- {
  --   'V4N1LLA-1CE/xcodedark.nvim',
  --   enabled = false,
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require('xcodedark').setup {
  --       transparent = false,
  --
  --       integrations = {
  --         telescope = false,
  --         nvim_tree = true,
  --         gitsigns = false,
  --         bufferline = true,
  --         incline = false,
  --         lazygit = false,
  --         which_key = true,
  --         notify = true,
  --       },
  --
  --       -- Font weight customization
  --       styles = {
  --         comments = { italic = true },
  --         keywords = { bold = true },
  --         functions = {},
  --         variables = {},
  --         strings = {},
  --         booleans = { bold = true },
  --         types = {},
  --         constants = {},
  --         operators = {},
  --         punctuation = {},
  --       },
  --
  --       terminal_colors = true,
  --     }
  --     vim.cmd.colorscheme 'xcodedark'
  --   end,
  -- },
}
