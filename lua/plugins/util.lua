return {

    { 'nvim-lua/plenary.nvim', name = 'plenary', dev = false, event = 'VeryLazy' },
    {
        'folke/ts-comments.nvim',
        name = 'ts-comments',
        event = 'VeryLazy',
        opts = {},
    },
    {
        'max397574/better-escape.nvim',
        name = 'better-escape',
        event = 'VeryLazy',
        config = function()
            require('better_escape').setup({
                -- timeout = vim.o.timeoutlen,
                timeout = 200,
                default_mappings = true,
                mappings = {
                    i = {
                        k = {
                            j = '<Esc>',
                        },
                        j = {
                            -- These can all also be functions
                            k = '<Esc>',
                            j = false,
                        },
                    },
                    c = {
                        j = {
                            k = '<Esc>',
                            j = false,
                        },
                        k = {
                            j = '<Esc>',
                        },
                    },
                    t = {
                        j = {
                            k = '<C-\\><C-n>',
                        },
                        k = {
                            j = '<Esc>',
                        },
                    },
                    v = {
                        j = {
                            k = '<Esc>',
                        },
                        k = {
                            j = '<Esc>',
                        },
                    },
                    s = {
                        j = {
                            k = '<Esc>',
                        },
                        k = {
                            j = '<Esc>',
                        },
                    },
                },
            })
        end,
    },
    {
        'mikesmithgh/kitty-scrollback.nvim',
        enabled = true,
        lazy = true,
        cmd = {
            'KittyScrollbackGenerateKittens',
            'KittyScrollbackCheckHealth',
            'KittyScrollbackGenerateCommandLineEditing',
        },
        event = { 'User KittyScrollbackLaunch' },
        -- version = '*', -- latest stable version, may have breaking changes if major version changed
        -- version = '^6.0.0', -- pin major version, include fixes and features that do not have breaking changes
        config = function()
            require('kitty-scrollback').setup()
        end,
    },
    {
        'vhyrro/luarocks.nvim',
        enabled = false,
        priority = 1001, -- this plugin needs to run before anything else
        opts = {
            rocks = { 'magick' },
        },
    },
    {
        'folke/persistence.nvim',
        name = 'persistence',
        event = 'BufReadPre',
        opts = {},
        keys = {
            {
                '<leader>sr',
                function()
                    require('persistence').load()
                end,
                desc = 'Restore Session',
            },
            {
                '<leader>sp',
                function()
                    require('persistence').select()
                end,
                desc = 'Pick Session',
            },
            {
                '<leader>sl',
                function()
                    require('persistence').load({ last = true })
                end,
                desc = 'Restore Last Session',
            },
            {
                '<leader>sd',
                function()
                    require('persistence').stop()
                end,
                desc = "Don't Save Current Session",
            },
        },
    },
    {
        '3rd/image.nvim',
        name = 'image',
        enabled = false,
        dependencies = { 'luarocks.nvim' },
        event = 'VeryLazy',
        config = function()
            require('image').setup({
                backend = 'kitty',
                integrations = {
                    markdown = {
                        enabled = true,
                        clear_in_insert_mode = false,
                        download_remote_images = true,
                        only_render_image_at_cursor = true,
                        filetypes = { 'markdown', 'vimwiki' }, -- markdown extensions (ie. quarto) can go here
                    },
                    neorg = {
                        enabled = true,
                        clear_in_insert_mode = false,
                        download_remote_images = true,
                        only_render_image_at_cursor = false,
                        filetypes = { 'norg' },
                    },
                    html = {
                        enabled = false,
                    },
                    css = {
                        enabled = false,
                    },
                },
                max_width = nil,
                max_height = nil,
                max_width_window_percentage = nil,
                max_height_window_percentage = 50,
                window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
                window_overlap_clear_ft_ignore = { 'cmp_menu', 'cmp_docs', '' },
                editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
                tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
                hijack_file_patterns = { '*.png', '*.jpg', '*.jpeg', '*.gif', '*.webp' }, -- render image files as images when opened
            })
        end,
    },

    {
        'folke/trouble.nvim',
        name = 'trouble',
        -- dependencies = { 'nvim-tree/nvim-web-devicons' },
        cmd = 'Trouble',
        opts = {
            preview = {
                type = 'main',
                -- type = 'split',
                -- relative = 'win',
                -- position = 'right',
                -- size = 0.3,
            },
        }, --config
        keys = {
            {
                '<leader>td',
                '<cmd>Trouble diagnostics toggle<cr>',
                desc = '[D]iagnostics',
            },
            {
                '<leader>tb',
                '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
                desc = '[B]uffer Diagnostics',
            },
            {
                '<leader>ts',
                '<cmd>Trouble symbols toggle focus=false<cr>',
                desc = '[S]ymbols',
            },
            {
                '<leader>tl',
                '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
                desc = '[L]SP info',
            },
            {
                '<leader>tL',
                '<cmd>Trouble loclist toggle<cr>',
                desc = '[L]ocation List',
            },
            {
                '<leader>tQ',
                '<cmd>Trouble qflist toggle<cr>',
                desc = '[Q]uickfix List',
            },
        },
    },
}
