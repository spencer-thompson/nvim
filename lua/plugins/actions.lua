return {

    {
        'kylechui/nvim-surround',
        enabled = true,
        name = 'surround',
        version = '*', -- Use for stability; omit to use `main` branch for the latest features
        event = 'VeryLazy',
        config = function()
            require('nvim-surround').setup({
                -- Configuration here, or leave empty to use defaults
                keymaps = {
                    insert = false,
                    insert_line = false,
                    normal = 'ys',
                    normal_cur = 'yss',
                    normal_line = 'yS',
                    normal_cur_line = 'ySS',
                    visual = 'S',
                    visual_line = false,
                },
            })
        end,
    },

    {
        'windwp/nvim-autopairs',
        name = 'autopairs',
        event = 'InsertEnter',
        opts = {}, -- this is equalent to setup({}) function
    },

    { 'tpope/vim-repeat', name = 'repeat', event = 'VeryLazy' }, -- better repeating with plugins

    {
        'numToStr/Comment.nvim',
        name = 'comment',
        event = 'VeryLazy',
        enabled = false,
        config = function()
            require('Comment').setup({
                padding = true,
                sticky = true,
                -- ignore = nil,
                toggler = {
                    line = 'gcc',
                    -- block = 'gbc'
                },
                opleader = {
                    line = 'gc',
                    -- block = 'gb'
                },
                extra = { above = 'gcO', below = 'gco', eol = 'gcA' },
                mappings = { basic = true, extra = true },
                -- pre_hook = nil,
                -- post_hook = nil,
            })

            local comment_ft = require('Comment.ft')
            comment_ft.set('lua', { '--%s', '--[[%s]]' })
        end,
    },

    { -- make TODO + ":" a fancy colored comment.
        'folke/todo-comments.nvim',
        name = 'todo-comments',
        event = 'VeryLazy',
        dependecies = { 'nvim-lua/plenary.nvim', name = 'plenary' },
        opts = {
            keywords = {
                DONE = { icon = ' ', color = 'info' },
                TODO = { icon = '󰵚 ', color = 'info' },
            },
            merge_keywords = true,
        },
        keys = {
            -- keymaps
            {
                ']t',
                function()
                    require('todo-comments').jump_next()
                end,
                desc = 'Next todo comment',
            },
            {
                '[t',
                function()
                    require('todo-comments').jump_prev()
                end,
                desc = 'Previous todo comment',
            },
        },
        config = true,
    },

    { -- NOTE: Only on linux
        'michaelb/sniprun',
        event = 'VeryLazy',
        enabled = false,
        lazy = true,
        build = 'sh install.sh',
        config = function()
            require('sniprun').setup({
                display = { 'VirtualText' },
                snipruncolors = {
                    SniprunVirtualTextOk = { bg = 'NONE', fg = 'Cyan', ctermbg = 'NONE', ctermfg = 'Cyan' },
                    -- SniprunFloatingWinOk = { fg = '#66eeff', ctermfg = 'Cyan' },
                    SniprunVirtualTextErr = { bg = 'NONE', fg = 'Red', ctermbg = 'NONE', ctermfg = 'Red' },
                    -- SniprunFloatingWinErr = { fg = '#881515', ctermfg = 'DarkRed', bold = true },
                },
            })
            vim.keymap.set('v', '<leader>R', function()
                require('sniprun').run('v')
                vim.defer_fn(require('sniprun.display').close_all, 10000) -- close after 10 sec
            end, { silent = true, desc = '[R]un Visual Selection' })

            -- vim.keymap.set('v', '<leader>r', '<Plug>SnipRun', { silent = true, desc = '[R]un Visual Selection' })

            -- vim.keymap.set('n', '<leader>r', function()
            --     require('sniprun').run('n')
            --     vim.defer_fn(require('sniprun.display').close_all, 10000)
            -- end, { silent = true, desc = '[R]un Visual Selection' })
            -- , '<cmd>SnipRun<CR>'
            -- vim.api.nvim_set_keymap('v', 'f', '<Plug>SnipRun', { silent = true })
            -- vim.api.nvim_set_keymap('n', '<leader>f', '<Plug>SnipRunOperator', { silent = true })
            -- vim.api.nvim_set_keymap('n', '<leader>ff', '<Plug>SnipRun', { silent = true })
        end,
    },
}
