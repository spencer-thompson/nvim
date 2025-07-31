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

vim.wo.number = true -- line numbers
vim.opt.rnu = true -- relative line numbers

vim.o.mouse = 'a' -- mouse mode
vim.o.mousescroll = 'ver:3,hor:0' -- Disable horizontal scrolling.
vim.o.clipboard = 'unnamedplus' -- sync clipboards

vim.o.timeout = false
vim.o.updatetime = 300
vim.o.timeoutlen = 500
vim.o.ttimeoutlen = 10

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.breakindent = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.smartcase = true
vim.opt.ignorecase = true

vim.opt.smartindent = true

vim.opt.wrap = false
vim.opt.showbreak = '│ ' -- only for wrap -- ┊│▕
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 36 -- set to 999 for "always centered"
-- vim.opt.sidescroll = 0 -- this one for horizontal

vim.opt.linebreak = true
vim.opt.breakindent = true

vim.opt.laststatus = 3

vim.opt.jumpoptions = 'stack'
-- vim.opt.autochdir = true -- auto cd to new directory

vim.opt.spelllang = 'en_us'
vim.opt.spell = true

-- default 'tcqj'
vim.opt.formatoptions = vim.opt.formatoptions
    - 'a' -- auto formatting is bad
    - 't' -- no auto formatting
    + 'c' -- auto wrap comments
    + 'q' -- allow formatting comments w/ gq
    + 'r' -- unless pressing enter
    - 'o' -- O and o, don't continue comments
    + 'n' -- indent past the formatlistpat, not underneath it
    - '2'
    + 'j' -- remove comment leader when joining lines

-- Folding.
vim.o.foldcolumn = '0'
vim.opt.foldlevel = 99
vim.o.foldlevelstart = 99
vim.wo.foldtext = ''
vim.opt.foldmethod = 'expr'
vim.opt.foldenable = true
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

-- set "~" to "`" { '─', '│', '─', '│', '┌', '┐', '┘', '└'},
vim.opt.fillchars = {
    horiz = '─',
    horizup = '┴',
    horizdown = '┬',
    vert = '│',
    -- vert = ' ',
    -- msgsep = '│',
    vertleft = '┤',
    vertright = '├',
    verthoriz = '┼',
    msgsep = '─',
    eob = ' ',
    fold = ' ',
    foldsep = ' ',
    foldclose = '',
    foldopen = '',
}

-- Completion.
vim.opt.wildignore:append({ '.DS_Store' })
vim.o.completeopt = 'menuone,noselect,noinsert'
vim.o.pumblend = 20 -- Make builtin completion menus slightly transparent
vim.o.pumheight = 30 -- Make popup menu smaller
-- vim.o.winblend = 10 -- Make floating windows slightly transparent
-- vim.o.listchars = 'tab:> ,extends:…,precedes:…,nbsp:␣,eol:↴' -- Define which helper symbols to show
-- vim.o.listchars = 'tab:    ,extends:…,precedes:…,nbsp:␣' -- Define which helper symbols to show
vim.opt.listchars = { space = '⋅', trail = '⋅', tab = '  ↦' }
vim.o.list = false -- Show some helper symbols
vim.opt.conceallevel = 0
-- vim.opt.concealcursor = 'nc'

vim.opt.shortmess:append({
    m = true,
    r = true,
    w = true,
    s = true,
    W = true, -- no written message
})

-- save undo history
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath('data') .. '/.undo'
vim.opt.undofile = true

-- set highlight on search
vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.o.completeopt = 'menu,menuone,noinsert,preview'
vim.opt.termguicolors = true
vim.o.virtualedit = 'block' -- Allow going past the end of line in visual block mode

vim.opt.cursorline = true
vim.opt.cursorlineopt = 'number'

vim.opt.showtabline = 2

vim.o.keywordprg = 'wn'

vim.o.winborder = 'single'
local left = require('icons').lines.left.vertical
local center = require('icons').lines.center.vertical
local right = require('icons').lines.right.vertical
vim.o.statuscolumn = '%s' .. left .. '%l'

-- %l	line number column for currently drawn line
-- %s	sign column for currently drawn line
-- %C	fold column for currently drawn line
