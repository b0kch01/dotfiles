-- OPTIONS

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

---- Indentation
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.breakindent = true
vim.opt.tabstop = 4

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.lsp.foldexpr()"
vim.opt.foldtext = "v:lua.vim.lsp.foldtext()"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

---- Gutter
vim.opt.signcolumn = 'auto'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

---- UI
vim.opt.cmdheight = 0
vim.opt.mouse = 'a'
vim.opt.showmode = false

vim.opt.list = true
vim.opt.listchars = {tab = '» ', trail = '·', nbsp = '␣'}
vim.opt.inccommand = 'split'
vim.opt.termguicolors = true


---- Clipboard
vim.opt.clipboard = ""
vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)

---- Behavior
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.updatetime = 250
vim.opt.timeoutlen = 1000
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.scrolloff = 15

vim.g.editorconfig = true





































