vim.wo.number = true
vim.opt.rnu = true

vim.o.mouse = 'a'
vim.o.clipboard = 'unnamedplus' -- sync clipboards

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.smartcase = true
vim.opt.ignorecase = true

vim.opt.smartindent = true

vim.opt.wrap = false

-- set "~" to "`"
vim.opt.fillchars = {
    horiz = '━',
    horizup = '┻',
    horizdown = '┳',
    vert = '┃',
    vertleft = '┫',
    vertright = '┣',
    verthoriz = '╋',
    eob = ' ',
}

-- save undo history
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath('data') .. '/.undo'
vim.undofile = true

-- set highlight on search
vim.hlsearch = false
vim.incsearch = true


vim.o.completeopt = 'menu,menuone,noinsert,preview'
vim.opt.termguicolors = true

-- set to 999 for "always centered"
vim.opt.scrolloff = 999

vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 1000

vim.opt.showtabline = 2
