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
            { 'kristijanhusak/vim-dadbod-completion', name = 'dadbod-completions' },
            {
                'brenoprata10/nvim-highlight-colors',
                name = 'highlight-colors',
                config = function()
                    require('nvim-highlight-colors').setup({

                        render = 'virtual',
                        ---Set virtual symbol (requires render to be set to 'virtual')
                        virtual_symbol = ' ',

                        ---Set virtual symbol suffix (defaults to '')
                        virtual_symbol_prefix = ' ',

                        ---Set virtual symbol suffix (defaults to ' ')
                        virtual_symbol_suffix = '',

                        ---Set virtual symbol position()
                        ---@usage 'inline'|'eol'|'eow'
                        ---inline mimics VS Code style
                        ---eol stands for `end of column` - Recommended to set `virtual_symbol_suffix = ''` when used.
                        ---eow stands for `end of word` - Recommended to set `virtual_symbol_prefix = ' ' and virtual_symbol_suffix = ''` when used.
                        virtual_symbol_position = 'eow',

                        ---Highlight hex colors, e.g. '#FFFFFF'
                        enable_hex = true,

                        ---Highlight short hex colors e.g. '#fff'
                        enable_short_hex = true,

                        ---Highlight rgb colors, e.g. 'rgb(0 0 0)'
                        enable_rgb = true,

                        ---Highlight hsl colors, e.g. 'hsl(150deg 30% 40%)'
                        enable_hsl = true,

                        ---Highlight CSS variables, e.g. 'var(--testing-color)'
                        enable_var_usage = true,

                        ---Highlight named colors, e.g. 'green'
                        enable_named_colors = true,

                        ---Highlight tailwind colors, e.g. 'bg-blue-500'
                        enable_tailwind = false,

                        ---Set custom colors
                        ---Label must be properly escaped with '%' to adhere to `string.gmatch`
                        --- :help string.gmatch
                        -- custom_colors = {
                        --     { label = '%-%-theme%-primary%-color', color = '#0f1219' },
                        --     { label = '%-%-theme%-secondary%-color', color = '#5a5d64' },
                        -- },

                        -- Exclude filetypes or buftypes from highlighting e.g. 'exclude_buftypes = {'text'}'
                        exclude_filetypes = {},
                        exclude_buftypes = {},
                    })
                end,
            },
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
