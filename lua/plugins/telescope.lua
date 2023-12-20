return {
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.5',
        -- or                              , branch = '0.1.x',
        event = 'VeryLazy',
        dependencies = {
            
            "nvim-telescope/telescope-file-browser.nvim",
            "nvim-telescope/telescope-hop.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                -- NOTE: If you are having trouble with this installation,
                --       refer to the README for telescope-fzf-native for more instructions.
                build = 'make',
                cond = function()
                    return vim.fn.executable 'make' == 1
                end,
            },
        },


        config = function()
            local actions = require("telescope.actions")

            require('telescope').setup {
                defaults = {
                    mappings = {
                        i = {
                            ['<C-u>'] = false,
                            ['<C-d>'] = false,
                            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
                            ["<C-j>"] = actions.move_selection_next, -- move to next result
                        },
                    },
                },
            }
            -- Enable telescope fzf native, if installed
            pcall(require('telescope').load_extension, 'fzf')
            -- pcall(require('telescope').extensions.notify.notify())

            -- Setup keymaps i guess
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
            vim.keymap.set('n', '<leader>fs', builtin.live_grep, {})
            vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

        end,

    },
}
