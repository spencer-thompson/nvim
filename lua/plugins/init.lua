return {
    { "nvim-lua/plenary.nvim", dev = false },

    'kyazdani42/nvim-web-devicons',
    { 'tpope/vim-sleuth', event = 'VeryLazy' },
    { 'milisims/nvim-luaref', event = 'VeryLazy' },-- lua help
    { 'tpope/vim-surround', event = 'VeryLazy' },-- [command]s[change][to]
    { 'tpope/vim-repeat', event = 'VeryLazy' },-- better repeating with plugins
    -- 'tpope/vim-abolish', -- cool words

    {
        'folke/trouble.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {} --config
    },
    { 'folke/which-key.nvim', event = 'VeryLazy', opts = {} },
}
