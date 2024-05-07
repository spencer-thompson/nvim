return {

    { 'nvim-lua/plenary.nvim', name = 'plenary', dev = false },

    {
        'vhyrro/luarocks.nvim',
        priority = 1001, -- this plugin needs to run before anything else
        opts = {
            rocks = { 'magick' },
        },
    },
    {
        '3rd/image.nvim',
        name = 'image',
        dependencies = { 'luarocks.nvim' },
        event = 'VeryLazy',
        -- config = function()
        --     -- ...
        -- end,
    },

    {
        'folke/trouble.nvim', -- better errors I think
        name = 'trouble',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        event = 'VeryLazy',
        opts = {}, --config
    },
}
