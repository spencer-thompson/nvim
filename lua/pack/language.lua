vim.schedule(function()
    vim.pack.add({
        { src = 'https://github.com/folke/lazydev.nvim' },
        { src = 'https://github.com/chomosuke/typst-preview.nvim', version = vim.version.range('1.*') },
        { src = 'https://github.com/mrcjkb/rustaceanvim', version = vim.version.range('^8') },
    })

    require('lazydev').setup({
        library = {
            { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
            { path = 'snacks.nvim', words = { 'Snacks' } },
        },
    })

    require('typst-preview').setup({})

    -- require('rustaceanvim').setup({})
end)
