return {
  'saghen/blink.cmp',
  dependencies = {
    'saghen/blink.lib',
  },

  build = function()
    require('blink.cmp').build()
    wait(60000)
  end,

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = { preset = 'enter' }
  }
}
