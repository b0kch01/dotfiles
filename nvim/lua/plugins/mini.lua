return {
  'nvim-mini/mini.nvim',
  config = function()
    require('mini.ai').setup({ n_lines = 500 })
    require('mini.pairs').setup()
    require('mini.splitjoin').setup()
    require('mini.surround').setup()

    require('mini.cursorword').setup({ delay = 600 })
    require('mini.indentscope').setup()
  end,
}
