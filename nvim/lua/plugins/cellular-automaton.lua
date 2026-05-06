return {
  'eandrju/cellular-automaton.nvim',
  init = function()
    vim.keymap.set('n', '<leader>fml', '<cmd>CellularAutomaton make_it_rain<CR>')
  end,
}
