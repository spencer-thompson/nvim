return {

    { "nvim-lua/plenary.nvim", dev = false },

    { 'milisims/nvim-luaref',  event = 'VeryLazy' }, -- lua help

    {
        'folke/trouble.nvim', -- better errors I think
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        event = "VeryLazy",
        opts = {} --config
    },
}
