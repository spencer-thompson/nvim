return {
    {
        'echasnovski/mini.align',
        version = '*',
        event = "VeryLazy",
        config = function()
            require('mini.align').setup()
        end,
    },
    {
        'echasnovski/mini.splitjoin',
        version = '*',
        event = "VeryLazy",
        config = function()
            require('mini.splitjoin').setup()
        end,
    }
}
