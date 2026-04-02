vim.pack.add({
    'https://github.com/folke/flash.nvim',
})

require('flash').setup({
    label = {
        after = false,
        before = true,
    },
})

vim.keymap.set({ 'n', 'x', 'o' }, 's', function()
    require('flash').jump()
end, { desc = 'Flash' })

vim.keymap.set({ 'n', 'o' }, 'S', function()
    require('flash').treesitter()
end, { desc = 'Flash Treesitter' })

vim.keymap.set('o', 'r', function()
    require('flash').remote()
end, { desc = '[R]emote Flash' })

vim.keymap.set('c', '<c-s>', function()
    require('flash').toggle()
end, { desc = 'Toggle Flash Search' })
