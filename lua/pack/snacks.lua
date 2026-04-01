vim.pack.add({
    'https://github.com/folke/snacks.nvim',
})

require('snacks').setup({
    input = { enabled = false },
    bigfile = { enabled = true },
    picker = { enabled = false },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = false },
    scroll = { enabled = false },
    statuscolumn = {
        enabled = true,

        left = function(win, buf)
            local is_neominimap = vim.bo[buf].filetype == 'neominimap'
            return is_neominimap and { 'sign' } or { 'mark', 'sign' }
        end,
        right = function(win, buf)
            local is_neominimap = vim.bo[buf].filetype == 'neominimap'
            return is_neominimap and { 'git' } or { 'fold', 'git' }
        end,
    },
    words = { enabled = false },
})
