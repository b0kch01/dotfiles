return {
  {
    'folke/snacks.nvim',
    lazy = false,
    opts = {
      notifier = { enabled = true },
      bufdelete = { enabled = true },
      indent = { enabled = true },
      toggle = { enabled = true },
      dashboard = {
        enabled = true,
        preset = {
          header = [[
Establish the work of our hands.
Yes, establish the work of our hands.
            ]],
        },
        sections = {
          { section = 'header' },
          { section = 'startup' },
        },
      },
    },

    keys = {
      {
        '<leader>bo',
        function()
          Snacks.bufdelete.other()
        end,
        desc = '[B]uffer Close [o]ther',
      },

      {
        '<leader>bd',
        function()
          Snacks.bufdelete.delete()
        end,
        desc = '[B]uffer [d]elete',
      },
    },
  },
}
