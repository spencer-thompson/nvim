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
            require('mini.splitjoin').setup({
                mappings = {
                    toggle = 'gS', -- default
                    split = 'gs',
                    join = 'gj',
                }
            })
        end,
    },
    {
        'echasnovski/mini.pairs',
        version = false,
        event = 'VeryLazy',
        config = function()
            require('mini.pairs').setup()
        end,
    },
}
