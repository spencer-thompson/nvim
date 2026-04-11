vim.schedule(function()
    vim.pack.add({
        { src = 'https://github.com/williamboman/mason.nvim', version = vim.version.range('*') },
    })

    require('mason').setup()
end)
