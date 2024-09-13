--[[PPYba,  ,adPPYba, 88,dPYba,,adPYba,  ,adPPYYba, 8b,dPPYba,  ,adPPYba,
88P'   "Y8 a8P_____88 88P'   "88"    "8a ""     `Y8 88P'    "8a I8[    ""
88         8PP""""""" 88      88      88 ,adPPPPP88 88       d8  `"Y8ba,
88         "8b,   ,aa 88      88      88 88,    ,88 88b,   ,a8" aa    ]8I
88          `"Ybbd8"' 88      88      88 `"8bbdP"Y8 88`YbbdP"'  `"YbbdP"'
                                                    88
                                                    88
                                                    ]]

-- jk to leave insert mode
vim.keymap.set({ 'i', 'v' }, 'jk', '<Esc>', { desc = 'Exit' })
vim.keymap.set('t', 'jk', '<C-\\><C-n>', { desc = 'Exit' }) -- same thing but for terminal mode

-- vim.keymap.set('n', '<leader>gc', function()
--     if vim.loop.os_uname().sysname == 'Windows_NT' then
--         vim.cmd('cd ~\\AppData\\Local\\nvim')
--     end
-- end, { desc = 'Go to [C]onfig' })

-- move lines up or down in visual mode
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move line(s) up' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move line(s) down' })

-- diagnostic stuff like errors
vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')

-- move through buffers
vim.keymap.set('n', '<leader>n', '<cmd>bnext<CR>', { desc = '[N]ext Buffer' })
vim.keymap.set('n', '<leader>N', '<cmd>bprevious<CR>', { desc = 'Previous Buffer' })
vim.keymap.set('n', '<leader>x', '<cmd>bdelete<CR>', { desc = 'Close Buffer' })
vim.keymap.set('n', '<leader>db', '<cmd>Dashboard<CR>', { desc = 'Dashboard' })

-- new line above / below cursor
vim.keymap.set('n', '<leader>o', 'mzo<esc>k`z', { desc = 'New line below cursor' })
vim.keymap.set('n', '<leader>O', 'mzO<esc>j`z', { desc = 'New line above cursor' })

-- visual block mode
vim.keymap.set('n', 'vb', '<C-v>', { desc = '[V]isual [B]lock Mode' })

-- doesn't add to register
vim.keymap.set('n', 'x', '"_x', { desc = 'No Register' })

-- center the window
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Center the window' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Center the window' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Center the window' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Center the window' })

-- select all
-- vim.keymap.set("n", "<C-a>", "gg<S-v>G", { desc = "Select [A]ll" })

-- select word under cursor
vim.keymap.set(
    'n',
    '<leader>S',
    [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = 'Select [S]ame Word' }
)

-- fix last misspelled word and jump back
vim.keymap.set('n', '<leader>z', 'mz[s1z=`z', { desc = 'Fix last misspelled word' })

-- paste without overwriting the clipboard
vim.keymap.set('x', '<leader>p', [["_dP]], { desc = 'Paste without overwriting' })
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]], { desc = 'Copy to +y register' })
vim.keymap.set('n', '<leader>Y', [["+Y]], { desc = 'Copy to +Y register' })

-- splits
vim.keymap.set('n', '<leader>ss', '<cmd>split<CR>', { desc = 'Horizontal Screen Split' })
vim.keymap.set('n', '<leader>sv', '<cmd>vsplit<CR>', { desc = 'Vertical Screen Split' })
vim.keymap.set('n', '<leader>st', '<cmd>vsplit<CR><cmd>terminal<CR>A', { desc = 'Vertical Terminal Screen Split' })
vim.keymap.set('n', '<leader>sT', '<cmd>split<CR><cmd>terminal<CR>A', { desc = 'Horizontal Terminal Screen Split' })

-- move window
vim.keymap.set({ 'n', 't' }, '<C-h>', '<C-w>h', { desc = 'Left Window' })
vim.keymap.set({ 'n', 't' }, '<C-k>', '<C-w>k', { desc = 'Up Window' })
vim.keymap.set({ 'n', 't' }, '<C-j>', '<C-w>j', { desc = 'Down Window' })
vim.keymap.set({ 'n', 't' }, '<C-l>', '<C-w>l', { desc = 'Right Window' })

vim.keymap.set(
    'n',
    '<C-Left>',
    '"<Cmd>vertical resize -" . v:count1 . "<CR>"',
    { expr = true, replace_keycodes = false, desc = 'Decrease window width' }
)
vim.keymap.set(
    'n',
    '<C-Down>',
    '"<Cmd>resize -"          . v:count1 . "<CR>"',
    { expr = true, replace_keycodes = false, desc = 'Decrease window height' }
)
vim.keymap.set(
    'n',
    '<C-Up>',
    '"<Cmd>resize +"          . v:count1 . "<CR>"',
    { expr = true, replace_keycodes = false, desc = 'Increase window height' }
)
vim.keymap.set(
    'n',
    '<C-Right>',
    '"<Cmd>vertical resize +" . v:count1 . "<CR>"',
    { expr = true, replace_keycodes = false, desc = 'Increase window width' }
)
-- -- resize windows
-- vim.keymap.set('n', '+', [[<cmd>vertical resize +5<cr>]], { desc = 'Bigger Window' })
-- vim.keymap.set('n', '-', [[<cmd>vertical resize -5<cr>]], { desc = 'Smaller Window' })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true }) -- might remove
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- saving & quiting
vim.keymap.set('n', '<leader>q', '<cmd>q<CR>', { desc = '[Q]uit' })
vim.keymap.set('n', '<leader>Q', '<cmd>q!<CR>', { desc = 'Force [Q]uit' })
vim.keymap.set('n', '<leader>w', '<cmd>w<CR>', { desc = '[W]rite' })
vim.keymap.set('n', 'Q', '<nop>')

-- quick source
-- vim.keymap.set("n", "<leader><leader>", "gqq", {desc= "Format"})
