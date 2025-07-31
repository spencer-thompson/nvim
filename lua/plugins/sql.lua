return {
    {
        'kristijanhusak/vim-dadbod-ui',
        enabled = false,
        name = 'dadbod-ui',
        dependencies = {
            { 'tpope/vim-dadbod', name = 'dadbod', lazy = true },
        },
        cmd = {
            'DBUI',
            'DBUIToggle',
            'DBUIAddConnection',
            'DBUIFindBuffer',
        },
        init = function()
            vim.g.db_ui_use_nerd_fonts = 1
            vim.g.db_ui_use_nvim_notify = 1
            vim.g.db_ui_winwidth = 40
        end,
    },
    {
        'kopecmaciej/vi-mongo.nvim',
        name = 'vi-mongo',
        enabled = false,
        config = function()
            require('vi-mongo').setup()
        end,
        cmd = { 'ViMongo' },
        keys = {
            { '<leader>vm', '<cmd>ViMongo<cr>', desc = 'Mongo Client' },
        },
    },
    {
        'kndndrj/nvim-dbee',
        name = 'dbee',
        lazy = true,
        -- event = 'VeryLazy',
        dependencies = {
            'MunifTanjim/nui.nvim',
        },
        build = function()
            -- Install tries to automatically detect the install method.
            -- if it fails, try calling it with one of these parameters:
            --    "curl", "wget", "bitsadmin", "go"
            require('dbee').install()
        end,
        config = function()
            require('dbee').setup({

                editor = {
                    -- see drawer comment.
                    -- window_options = {},
                    -- buffer_options = {},

                    -- directory where to store the scratchpads.
                    --directory = "path/to/scratchpad/dir",

                    -- mappings for the buffer
                    mappings = {
                        -- run what's currently selected on the active connection
                        { key = '<leader>r', mode = 'v', action = 'run_selection' },
                        -- run the whole file on the active connection
                        { key = '<leader>r', mode = 'n', action = 'run_file' },
                    },
                },
            })
            vim.keymap.set('n', '<leader>dB', function()
                require('dbee').toggle()
            end, { desc = '[D]ata[B]ase' })
        end,
    },
}
