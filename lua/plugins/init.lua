return {
    { "nvim-lua/plenary.nvim", dev = false },

    'tpope/vim-fugitive', -- git stuff
    'tpope/vim-sleuth',
    'kyazdani42/nvim-web-devicons', 
    'milisims/nvim-luaref', -- lua help
    'tpope/vim-surround', -- [command]s[change][to]
    'tpope/vim-repeat', -- better repeating with plugins
    -- 'tpope/vim-abolish', -- cool words

    {
        'folke/trouble.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {} --config
    },
    { 'folke/which-key.nvim', opts = {} },
    
    -- 'nvim-treesitter/playground',
    -- 'JoosepAlviste/nvim-ts-context-commentstring',
    -- 'nvim-treesitter/nvim-treesitter-context',
}
