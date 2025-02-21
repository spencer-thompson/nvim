return {
    {
        'vyfor/cord.nvim',
        name = 'cord',
        enabled = false,
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
