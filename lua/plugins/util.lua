return {

    { 'nvim-lua/plenary.nvim', name = 'plenary', dev = false },

    {
        'folke/trouble.nvim', -- better errors I think
        name = 'trouble',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        event = 'VeryLazy',
        opts = {}, --config
    },
}
