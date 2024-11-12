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

vim.wo.number = true
vim.opt.rnu = true

vim.o.mouse = 'a'
-- Disable horizontal scrolling.
vim.o.mousescroll = 'ver:3,hor:0'
vim.o.clipboard = 'unnamedplus' -- sync clipboards

vim.o.timeout = true
vim.o.updatetime = 300
vim.o.timeoutlen = 500
vim.o.ttimeoutlen = 10

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.smartcase = true
vim.opt.ignorecase = true

vim.opt.smartindent = true

vim.opt.wrap = false
vim.opt.showbreak = '│ ' --┊│▕
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 36 -- set to 999 for "always centered"
-- vim.opt.sidescroll = 0

vim.opt.linebreak = true
vim.opt.breakindent = true

vim.opt.laststatus = 3

vim.opt.jumpoptions = 'stack'

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
vim.o.foldcolumn = '1'
vim.opt.foldlevel = 99
vim.o.foldlevelstart = 99
vim.wo.foldtext = ''
vim.opt.foldmethod = 'indent'
vim.opt.foldenable = true

-- set "~" to "`" { '─', '│', '─', '│', '┌', '┐', '┘', '└'},
vim.opt.fillchars = {
    horiz = '─',
    horizup = '┴',
    horizdown = '┬',
    vert = '│',
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

vim.opt.shortmess:append({
    w = true,
    s = true,
})

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
vim.o.virtualedit = 'block' -- Allow going past the end of line in visual block mode

vim.opt.cursorline = true
vim.opt.cursorlineopt = 'number'
-- vim.api.nvim_set_hl(0, 'CursorLineNr', { link = 'ModeMsg' })

-- vim.opt.signcolumn = 'yes:2'
-- vim.opt.signcolumn = 'yes:1'

vim.opt.showtabline = 2
