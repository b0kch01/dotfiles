-- KEYMAPS

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', ' ', '<nop>', { silent = true })
vim.keymap.set('n', '<leader>cl', '<cmd>set relativenumber!<CR><cmd>set number!<CR>', { desc = 'Config: Toggle relative line number' })
vim.keymap.set('n', '<leader>cr', '<cmd>source %<CR>', { desc = 'Config: reload' })

vim.keymap.set("i", "<C-c>", "<Esc>", { noremap = true, silent = true })
