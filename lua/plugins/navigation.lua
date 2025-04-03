return {

    { -- vscode style file browser, I don't use anymore
        'nvim-neo-tree/neo-tree.nvim',
        name = 'neo-tree',
        branch = 'v3.x',
        event = 'VeryLazy',
        enabled = false,
        dependencies = {
            { 'nvim-lua/plenary.nvim', name = 'plenary' },
            -- { 'nvim-tree/nvim-web-devicons' }, -- not strictly required, but recommended
            { 'MunifTanjim/nui.nvim', name = 'nui' },
            -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        },
    },

    { -- This is for selecting treesitter nodes
        'aaronik/treewalker.nvim',
        enabled = true,
        name = 'treewalker',
        event = 'VeryLazy',
        -- defaults
        opts = {
            -- Whether to briefly highlight the node after jumping to it
            highlight = true,

            -- How long should above highlight last (in ms)
            highlight_duration = 150,

            -- The color of the above highlight. Must be a valid vim highlight group.
            -- (see :h highlight-group for options)
            highlight_group = 'CursorLine',
        },
        config = function()
            local treewalker = require('treewalker').setup({
                -- Whether to briefly highlight the node after jumping to it
                highlight = true,

                -- How long should above highlight last (in ms)
                highlight_duration = 250,

                -- The color of the above highlight. Must be a valid vim highlight group.
                -- (see :h highlight-group for options)
                highlight_group = 'CursorLine',
            })
            -- vim.keymap.set("v", "<C-h>", function() treewalker)
            -- movement
            vim.keymap.set({ 'n', 'v' }, '<leader>k', '<cmd>Treewalker Up<cr>', { silent = true })
            vim.keymap.set({ 'n', 'v' }, '<leader>j', '<cmd>Treewalker Down<cr>', { silent = true })
            vim.keymap.set({ 'n', 'v' }, '<leader>l', '<cmd>Treewalker Right<cr>', { silent = true })
            vim.keymap.set({ 'n', 'v' }, '<leader>h', '<cmd>Treewalker Left<cr>', { silent = true })

            -- swapping
            vim.keymap.set('n', '<leader>J', '<cmd>Treewalker SwapDown<cr>', { silent = true })
            vim.keymap.set('n', '<leader>K', '<cmd>Treewalker SwapUp<cr>', { silent = true })
            vim.keymap.set('n', '<leader>L', '<cmd>Treewalker SwapRight<CR>', { silent = true })
            vim.keymap.set('n', '<leader>H', '<cmd>Treewalker SwapLeft<CR>', { silent = true })
        end,
    },

    { -- This is better w, b, and e
        'chrisgrieser/nvim-spider',
        lazy = true,
        enabled = false,
        event = 'VeryLazy',
        keys = {
            { 'w', "<cmd>lua require('spider').motion('w')<CR>", mode = { 'n', 'o', 'x' } },
            { 'e', "<cmd>lua require('spider').motion('e')<CR>", mode = { 'n', 'o', 'x' } },
            { 'b', "<cmd>lua require('spider').motion('b')<CR>", mode = { 'n', 'o', 'x' } },
        },
    },

    { -- quick switching between buffers
        'leath-dub/snipe.nvim',
        name = 'snipe',
        enabled = false,
        event = 'VeryLazy',
        keys = {
            {
                '<leader><leader>',
                function()
                    require('snipe').open_buffer_menu()
                end,
                desc = 'Open Snipe buffer menu',
            },
        },
        opts = {},
    },

    {
        'folke/flash.nvim',
        -- Quick motions/movement
        name = 'flash',
        event = 'VeryLazy',
        vscode = true,
        opts = {
            label = {
                after = false,
                before = true,
            },
        },
        keys = {
            {
                'S',
                mode = { 'n', 'x', 'o' },
                function()
                    require('flash').jump()
                end,
                desc = 'Flash',
            },
            -- {
            --     'S',
            --     mode = { 'n', 'o', 'x' },
            --     function()
            --         require('flash').treesitter()
            --     end,
            --     desc = 'Flash Treesitter',
            -- },
            {
                'r',
                mode = 'o',
                function()
                    require('flash').remote()
                end,
                desc = 'Remote Flash',
            },
            -- {
            --     'R',
            --     mode = { 'o', 'x' },
            --     function()
            --         require('flash').treesitter_search()
            --     end,
            --     desc = 'Treesitter Search',
            -- },
            {
                '<c-s>',
                mode = { 'c' },
                function()
                    require('flash').toggle()
                end,
                desc = 'Toggle Flash Search',
            },
        },
    },

    {
        'christoomey/vim-tmux-navigator',
        name = 'tmux-navigator',
        enabled = false,
        lazy = false,
    },
}
