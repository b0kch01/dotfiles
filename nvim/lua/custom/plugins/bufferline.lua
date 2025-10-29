return {
  'akinsho/bufferline.nvim',
  lazy = true,
  event = 'BufRead',
  keys = {
    { '<Tab>', '<cmd>BufferLineCycleNext<CR>', desc = 'Next buffer tab' },
    { '<S-Tab>', '<cmd>BufferLineCyclePrev<CR>', desc = 'Previous buffer tab' },
  },
  config = function()
    local mocha = require('catppuccin.palettes').get_palette 'mocha'

    local highlights = require('catppuccin.special.bufferline').get_theme {
      styles = { 'italic', 'bold' },
      custom = {
        all = {
          fill = { bg = '#000000' },
        },
        mocha = {
          background = { fg = mocha.text },
        },
      },
    }

    require('bufferline').setup {
      highlights = highlights,
      options = {
        indicator = {
          style = 'underline',
        },
        offsets = {
          {
            filetype = 'neo-tree',
            text = '',
            highlight = 'Directory',
            text_align = 'center',
            separator = false,
          },
        },
      },
    }
  end,
}
