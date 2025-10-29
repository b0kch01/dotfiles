return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  enabled = true,
  event = 'VeryLazy',

  opts = function()
    local palette = require 'catppuccin.palettes.mocha'
    local bg_color = palette.surface0
    local fg_color = palette.subtext0

    local sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {
        {
          'branch',
          icon = '',
        },
        'filename',
        '%=',
        {
          'diagnostics',
          symbols = {
            error = ' ',
            warn = ' ',
            info = ' ',
            hint = ' ',
          },
        },
      },
      lualine_x = {
        {
          function()
            local line = vim.fn.line '.'
            local col = vim.fn.charcol '.'
            return string.format('Ln %d, Col %d', line, col)
          end,
        },
        'filetype',
      },
      lualine_y = {},
      lualine_z = {},
    }

    local treeSections = vim.deepcopy(sections)
    treeSections.lualine_c[2] = ''

    local config = {
      options = {
        globalstatus = true,
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        -- disabled_filetypes = { 'neo-tree' },
        theme = {
          normal = {
            c = {
              fg = fg_color,
              bg = bg_color,
            },
          },
        },
      },
      sections = sections,
      extensions = {
        {
          sections = treeSections,
          filetypes = { 'neo-tree' },
        },
      },
    }

    return config
  end,
}
