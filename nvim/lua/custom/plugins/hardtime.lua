return {
  enabled = false,
  'm4xshen/hardtime.nvim',
  lazy = false,
  dependencies = { 'MunifTanjim/nui.nvim' },
  opts = {
    disabled_filetypes = {
      'netrw',
      'NvimTree',
      'lazy',
      'mason',
    },
  },
}
