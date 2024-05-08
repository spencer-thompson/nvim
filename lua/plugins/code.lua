return {

    {
        'neovim/nvim-lspconfig',
        name = 'lspconfig',
        cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'williamboman/mason.nvim', name = 'mason' },
            { 'williamboman/mason-lspconfig.nvim', name = 'mason-lspconfig' },
        },
    },

    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            { 'onsails/lspkind-nvim', name = 'lspkind' },
            { 'L3MON4D3/LuaSnip', name = 'luasnip' },
            { 'hrsh7th/cmp-buffer' },
            { 'rafamadriz/friendly-snippets', name = 'friendly-snippets' },
            { 'saadparwaiz1/cmp_luasnip', name = 'cmp-luasnip' },
            { 'hrsh7th/cmp-cmdline' },
            { 'hrsh7th/cmp-nvim-lua' },
            { 'hrsh7th/cmp-path' },
            { 'f3fora/cmp-spell' },
            { 'garyhurtz/cmp_kitty', name = 'cmp-kitty' },
            { 'hrsh7th/cmp-emoji' },
            { 'chrisgrieser/cmp-nerdfont' },
            { 'kdheepak/cmp-latex-symbols' },
        },
    },

    { 'williamboman/mason.nvim', name = 'mason' },

    {
        'mbbill/undotree',
        name = 'undotree',
        event = 'VeryLazy',
        config = function()
            vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = '[U]ndotree' })
        end,
    },

    { 'tpope/vim-sleuth', event = 'VeryLazy' }, -- auto adjust shift and tabs
}
