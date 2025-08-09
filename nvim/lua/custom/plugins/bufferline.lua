return {
  'akinsho/bufferline.nvim',
  lazy = false,
  keys = {
    { '<Tab>', '<cmd>BufferLineCycleNext<CR>', desc = 'Next buffer tab' },
    { '<S-Tab>', '<cmd>BufferLineCyclePrev<CR>', desc = 'Previous buffer tab' },
  },
  opts = {
    options = {
      indicator = {
        style = 'underline',
      },
      offsets = {
        {
          filetype = 'neo-tree',
          text = 'File Explorer',
          highlight = 'Directory',
          text_align = 'center',
          separator = false,
        },
      },
    },
  },
}
