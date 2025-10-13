return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  enabled = true,
  event = 'VeryLazy',

  opts = function()
    -- local p = require('obscure.colors').setup { style = 'night' }
    local p = require('obscure.palettes').get_palette 'obscure'

    local colors = {
      bg = p.bg_statusline,
      bg2 = p.bg_dark1,
      fg = p.fg,
      yellow = p.yellow,
      cyan = p.cyan,
      green = p.green,
      orange = p.orange,
      violet = p.purple,
      magenta = p.purple,
      blue = p.blue,
      red = p.red,
    }

    local conditions = {
      buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand '%:t') ~= 1
      end,
      hide_in_width = function()
        return vim.fn.winwidth(0) > 80
      end,
      check_git_workspace = function()
        local filepath = vim.fn.expand '%:p:h'
        local gitdir = vim.fn.finddir('.git', filepath .. ';')
        return gitdir and #gitdir > 0 and #gitdir < #filepath
      end,
    }

    -- Config
    local config = {
      extensions = {
        'neo-tree',
      },
      options = {
        -- Disable sections and component separators
        icons_enabled = true,
        section_separators = '',
        component_separators = '',
        globalstatus = true,
        theme = {
          normal = {
            a = { fg = colors.fg, bg = colors.bg },
            y = { fg = colors.fg, bg = colors.bg },
            z = { fg = colors.fg, bg = colors.bg },
          },
          inactive = {
            a = { fg = colors.fg, bg = colors.bg },
            y = { fg = colors.fg, bg = colors.bg },
            z = { fg = colors.fg, bg = colors.bg },
          },
        },
        ignore_focus = {
          'neo-tree',
        },
      },
      sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      inactive_sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
    }

    local function ins_left(component)
      table.insert(config.sections.lualine_a, component)
    end

    local function ins_right(component)
      table.insert(config.sections.lualine_z, component)
    end

    local function ins_right2(component)
      table.insert(config.sections.lualine_y, component)
    end

    ins_left {
      function()
        return ''
      end,
      color = { fg = colors.red }, -- Sets highlighting of component
      padding = { left = 1, right = 1 }, -- We don't need space before this
    }

    ins_left {
      -- mode component
      function()
        return '1 Corinthians 1:18-31'
      end,
      color = function()
        -- auto change color according to neovims mode
        local mode_color = {
          n = colors.blue,
          i = colors.green,
          v = colors.red,
          [''] = colors.blue,
          V = colors.blue,
        }
        return { fg = mode_color[vim.fn.mode()] }
      end,
    }

    -- ins_left {
    --   -- filesize component
    --   'filesize',
    --   cond = conditions.buffer_not_empty,
    -- }

    ins_left {
      'filename',
      cond = conditions.buffer_not_empty,
      color = { fg = colors.magenta, gui = 'bold' },
    }

    -- ins_left { 'progress', color = { fg = colors.fg, gui = 'bold' } }

    -- Insert mid section. You can make any number of sections in neovim :)
    -- for lualine it's any number greater then 2
    ins_left {
      function()
        return '%='
      end,
    }

    ins_left {
      'diagnostics',
      sources = { 'nvim_diagnostic' },
      symbols = { error = ' ', warn = ' ', info = ' ' },
      diagnostics_color = {
        error = { fg = colors.red },
        warn = { fg = colors.yellow },
        info = { fg = colors.cyan },
      },
    }

    -- ins_right {
    --   -- Lsp server name .
    --   function()
    --     local msg = 'No Active Lsp'
    --     local buf_ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
    --     local clients = vim.lsp.get_clients()
    --     if next(clients) == nil then
    --       return msg
    --     end
    --     for _, client in ipairs(clients) do
    --       local filetypes = client.config.filetypes
    --       if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
    --         return client.name
    --       end
    --     end
    --     return msg
    --   end,
    --   icon = ' ',
    --   color = { fg = '#ffffff', gui = 'bold' },
    -- }

    -- Add components to right sections
    -- ins_right {
    --   'o:encoding', -- option component same as &encoding in viml
    --   fmt = string.upper, -- I'm not sure why it's upper case either ;)
    --   cond = conditions.hide_in_width,
    --   color = { fg = colors.green, gui = 'bold' },
    -- }
    --
    -- ins_right {
    --   'fileformat',
    --   fmt = string.upper,
    --   icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
    --   color = { fg = colors.green, gui = 'bold' },
    -- }

    ins_right2 {
      'branch',
      icon = '',
      color = { fg = colors.yellow, gui = 'bold' },
    }

    ins_right2 {
      'diff',
      -- Is it me or the symbol for modified is really weird
      symbols = { added = ' ', modified = ' ', removed = ' ' },
      diff_color = {
        added = { fg = colors.green },
        modified = { fg = colors.orange },
        removed = { fg = colors.red },
      },
      cond = conditions.hide_in_width,
    }

    -- ins_right {
    --   function()
    --     return '|'
    --   end,
    --
    --   padding = 0,
    -- }

    ins_right {
      'filetype',
    }

    -- ins_right {
    --   function()
    --     return '▊'
    --   end,
    --   color = { fg = colors.blue },
    --   padding = { left = 1 },
    -- }
    --
    ins_right { 'location', color = { bg = colors.bg2 } }

    -- Now don't forget to initialize lualine
    return config
  end,
}
