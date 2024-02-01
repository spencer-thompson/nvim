return {

    { "nvim-lua/plenary.nvim", name = 'plenary', dev = false },

    { 'milisims/nvim-luaref',  name = 'luaref',  event = 'VeryLazy' }, -- lua help

    {
        'folke/trouble.nvim', -- better errors I think
        name = 'trouble',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        event = "VeryLazy",
        opts = {} --config
    },
}
