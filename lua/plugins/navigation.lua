return {

    {
        'nvim-neo-tree/neo-tree.nvim',
        name = 'neo-tree',
        branch = 'v3.x',
        event = 'VeryLazy',
        dependencies = {
            { 'nvim-lua/plenary.nvim', name = 'plenary' },
            -- { 'nvim-tree/nvim-web-devicons' }, -- not strictly required, but recommended
            { 'MunifTanjim/nui.nvim', name = 'nui' },
            -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        },
        -- config = function()
        -- require('neo-tree').setup({
        --     close_if_last_window = true,
        --     sources = { 'filesystem', 'buffers', 'git_status', 'document_symbols' },
        --     -- default_component_configs = {
        --     --     indent = {
        --     --         indent_size = 4,
        --     --     }
        --     -- }
        -- })
        -- end,
    },

    {
        'aaronik/treewalker.nvim',

        enabled = false,
        name = 'treewalker',
        -- The following options are the defaults.
        -- Treewalker aims for sane defaults, so these are each individually optional,
        -- and setup() does not need to be called, so the whole opts block is optional as well.
        opts = {
            -- Whether to briefly highlight the node after jumping to it
            highlight = true,

            -- How long should above highlight last (in ms)
            highlight_duration = 250,

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
            vim.keymap.set('v', '<C-k>', '<cmd>Treewalker Up<cr>', { silent = true })
            vim.keymap.set('v', '<C-j>', '<cmd>Treewalker Down<cr>', { silent = true })
            vim.keymap.set('v', '<C-l>', '<cmd>Treewalker Right<cr>', { silent = true })
            vim.keymap.set('v', '<C-h>', '<cmd>Treewalker Left<cr>', { silent = true })

            -- swapping
            vim.keymap.set('n', '<C-S-j>', '<cmd>Treewalker SwapDown<cr>', { silent = true })
            vim.keymap.set('n', '<C-S-k>', '<cmd>Treewalker SwapUp<cr>', { silent = true })
            vim.keymap.set('n', '<C-S-l>', '<cmd>Treewalker SwapRight<CR>', { silent = true })
            vim.keymap.set('n', '<C-S-h>', '<cmd>Treewalker SwapLeft<CR>', { silent = true })
        end,
    },

    {
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
        'chentoast/marks.nvim',
        enabled = false,
        name = 'marks',
        event = 'VeryLazy',
        opts = {
            default_mappings = true,
        },
    },

    {
        'stevearc/oil.nvim',
        name = 'oil',
        enabled = false,
        event = 'VeryLazy',
        opts = {},
        -- Optional dependencies
        dependencies = { 'nvim-tree/nvim-web-devicons' },
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
                's',
                mode = { 'n', 'x', 'o' },
                function()
                    require('flash').jump()
                end,
                desc = 'Flash',
            },
            {
                'S',
                mode = { 'n', 'o', 'x' },
                function()
                    require('flash').treesitter()
                end,
                desc = 'Flash Treesitter',
            },
            {
                'r',
                mode = 'o',
                function()
                    require('flash').remote()
                end,
                desc = 'Remote Flash',
            },
            {
                'R',
                mode = { 'o', 'x' },
                function()
                    require('flash').treesitter_search()
                end,
                desc = 'Treesitter Search',
            },
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
