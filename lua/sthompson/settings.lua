vim.wo.number = true
vim.opt.rnu = true

vim.o.mouse = 'a'
vim.o.clipboard = 'unnamedplus' -- sync clipboards

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

-- set "~" to "`"
vim.opt.fillchars = 'eob:`'

-- save undo history
vim.undofile = true

-- set highlight on search
vim.hlsearch = false
vim.incsearch = true


vim.o.completeopt = 'menu,menuone,preview,noinsert'
vim.opt.termguicolors = true

vim.opt.scrolloff = 8

vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 50
