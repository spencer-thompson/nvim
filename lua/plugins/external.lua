return {
    {
        'vyfor/cord.nvim',
        name = 'cord',
        build = ':Cord update',
        event = 'VeryLazy',
        config = function()
            require('cord').setup({
                -- log_level = 'trace',
            })
            -- vim.print(require('cord.server').status)
        end,
    },
}
