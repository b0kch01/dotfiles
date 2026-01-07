-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Hide terminal  line number
vim.api.nvim_create_autocmd('TermOpen', {
  desc = 'Hide line number in terminal',
  group = vim.api.nvim_create_augroup('hide-terminal-line-numbers', { clear = true }),
  command = 'set nonumber',
})

-- Sort Tailwind classes on Save
vim.api.nvim_create_autocmd('BufWritePre', {
  desc = 'Sort Tailwind classes on save',
  group = vim.api.nvim_create_augroup('tailwind-sort-on-save', { clear = true }),
  pattern = { '*.ts', '*.tsx', '*.js', '*.jsx' },
  command = 'TailwindSort',
})
