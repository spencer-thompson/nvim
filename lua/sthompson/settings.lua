--[[                                 88
                       ,d      ,d    ""
                       88      88
,adPPYba,  ,adPPYba, MM88MMM MM88MMM 88 8b,dPPYba,   ,adPPYb,d8 ,adPPYba,
I8[    "" a8P_____88   88      88    88 88P'   `"8a a8"    `Y88 I8[    ""
 `"Y8ba,  8PP"""""""   88      88    88 88       88 8b       88  `"Y8ba,
aa    ]8I "8b,   ,aa   88,     88,   88 88       88 "8a,   ,d88 aa    ]8I
`"YbbdP"'  `"Ybbd8"'   "Y888   "Y888 88 88       88  `"YbbdP"Y8 `"YbbdP"'
                                                     aa,    ,88
                                                      "Y8bbd]]

--OS Specific stuff
-- if vim.loop.os_uname().sysname == "Windows_NT" then
--     vim.opt.shellslash = true
-- end

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
vim.opt.sidescroll = 8
vim.opt.showbreak = string.rep(" ", 3)
vim.opt.linebreak = true

vim.opt.laststatus = 3

vim.opt.spelllang = 'en_us'
vim.opt.spell = true

vim.opt.formatoptions = vim.opt.formatoptions
    -- default 'tcqj'
    - "a" -- auto formatting is bad
    - "t" -- no auto formatting
    + "c" -- auto wrap comments
    + "q" -- allow formatting comments w/ gq
    - "o" -- O and o, don't continue comments
    + "r" -- unless pressing enter
    + "n" -- indent past the formatlistpat, not underneath it
    - "2"
    + "j" -- remove comment leader when joining lines

-- set "~" to "`" { '─', '│', '─', '│', '┌', '┐', '┘', '└'},
vim.opt.fillchars = {
    horiz = '─',
    horizup = '┴',
    horizdown = '┬',
    vert = '│',
    vertleft = '┤',
    vertright = '├',
    verthoriz = '┼',
    eob = ' ',
}

-- save undo history
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath('data') .. '/.undo'
vim.opt.undofile = true

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
