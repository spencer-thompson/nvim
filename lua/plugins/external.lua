return {
    {
        'vyfor/cord.nvim',
        name = 'cord',
        build = ':Cord update',
        event = 'VeryLazy',
        config = function()
            require('cord').setup({})
        end,
    },
}
