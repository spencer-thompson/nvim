--[[PPYba,  ,adPPYba, 88,dPYba,,adPYba,  ,adPPYYba, 8b,dPPYba,  ,adPPYba,
88P'   "Y8 a8P_____88 88P'   "88"    "8a ""     `Y8 88P'    "8a I8[    ""
88         8PP""""""" 88      88      88 ,adPPPPP88 88       d8  `"Y8ba,
88         "8b,   ,aa 88      88      88 88,    ,88 88b,   ,a8" aa    ]8I
88          `"Ybbd8"' 88      88      88 `"8bbdP"Y8 88`YbbdP"'  `"YbbdP"'
                                                    88
                                                    88
                                                    ]]

-- jk to leave insert mode
-- vim.keymap.set({ 'i', 'v' }, 'jk', '<Esc>', { desc = 'Exit' })
vim.keymap.set('t', '<esc>', '<C-\\><C-n>', { desc = 'Exit' }) -- same thing but for terminal mode

-- move lines up or down in visual mode
-- vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move line(s) up' })
-- vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move line(s) down' })

-- indent while in remaining in visual mode
-- vim.keymap.set('v', '<', '<gv', { desc = 'Dedent' })
-- vim.keymap.set('v', '>', '>gv', { desc = 'Indent' })

if vim.env.TERM == 'xterm-kitty' then
    vim.cmd([[autocmd UIEnter * if v:event.chan ==# 0 | call chansend(v:stderr, "\x1b[>1u") | endif]])
    vim.cmd([[autocmd UILeave * if v:event.chan ==# 0 | call chansend(v:stderr, "\x1b[<1u") | endif]])
end

-- diagnostic stuff like errors
-- vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
-- vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')

-- new line above / below cursor
vim.keymap.set('n', '[o', 'moO<esc>k`o<cmd>delmarks o<cr>', { desc = 'New line above cursor' })
vim.keymap.set('n', ']o', 'moo<esc>j`o<cmd>delmarks o<cr>', { desc = 'New line below cursor' })

-- move through buffers
vim.keymap.set('n', '<leader><leader>', '<cmd>b#<cr>', { desc = 'Alternate Buffer' })

-- fix so that c-i and tab are seperate
-- This MUST come before the below
vim.keymap.set('n', '<c-i>', '<c-i>', { desc = 'Toggle Fold' })

-- tab for folding
vim.keymap.set('n', '<tab>', 'za', { desc = 'Toggle Fold' })

-- Make U opposite of u
vim.keymap.set('n', 'U', '<C-r>', { desc = 'Redo' })

-- visual block mode
vim.keymap.set('n', 'vb', '<C-v>', { desc = '[V]isual [B]lock Mode' })

-- doesn't add to register | might remove
vim.keymap.set('n', 'x', '"_x', { desc = 'No Register' })

-- center the window when moving
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Center the window' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Center the window' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Center the window' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Center the window' })

-- select word under cursor
vim.keymap.set(
    'n',
    '<leader>S',
    [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = 'Select [S]ame Word' }
)

-- fix last misspelled word and jump back, this is epic
vim.keymap.set('i', '<C-z>', '<esc>[s1z=gi', { desc = 'Fix last misspelled word' })
vim.keymap.set('n', '<leader>z', 'mz[s1z=`z<cmd>delmarks z<cr>', { desc = 'Fix last misspelled word' })

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

vim.keymap.set( -- these are replaced by a plugin, but good just in case
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

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true }) -- might remove
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- saving & quiting
vim.keymap.set({ 'n', 'x', 'v' }, '<leader>q', '<cmd>q<CR>', { desc = '[Q]uit' })
vim.keymap.set({ 'n', 'x', 'v' }, '<leader>Q', '<cmd>q!<CR>', { desc = 'Force [Q]uit' })
vim.keymap.set('n', '<leader>w', '<cmd>w<CR>', { desc = '[W]rite' })

vim.keymap.set('n', 'Q', '@@', { desc = 'Run Last Macro' })

vim.keymap.set('n', '<CR>', function()
    if vim.v.hlsearch == 1 then
        vim.cmd.nohl()
        return ''
    else
        return vim.keycode('<CR>')
    end
end, { expr = true })
