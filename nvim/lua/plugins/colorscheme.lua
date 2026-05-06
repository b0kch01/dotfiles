-- return {
--   'ribru17/bamboo.nvim',
--   config = function()
--     -- require('bamboo').setup()
--     -- require('bamboo').load()
--   end,
-- }

-- return {
--  'slugbyte/lackluster.nvim',
--   config = function()
--     vim.cmd.colorscheme('lackluster')
--   end,
-- }

return {
  'wnkz/monoglow.nvim',
  opts = {
    on_colors = function(colors)
      colors.glow = '#e25303'
    end,
  },
  config = function(_, opts)
    require('monoglow').setup(opts)
    vim.cmd.colorscheme('monoglow')
  end,
}
