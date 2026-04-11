vim.pack.add({
    'https://github.com/folke/snacks.nvim',
})

require('snacks').setup({
    input = { enabled = false },
    indent = {
        enabled = true,
        animate = {
            style = 'out',
            easing = 'linear',
            duration = {
                step = 15, -- ms per step
                total = 500, -- maximum duration
            },
        },
        indent = {
            char = '∙',
            only_scope = false,
            only_current = true,
        },
        chunk = {
            enabled = true,
            hl = 'Identifier',
            char = {
                corner_top = '┌',
                corner_bottom = '└',
                -- corner_top = '╭',
                -- corner_bottom = '╰',
                horizontal = '─',
                vertical = '│',
                arrow = '╴',
                -- arrow = '╴─',
                -- arrow = require('icons').arrows.right,
            },
        },
        scope = {
            enabled = false,
            char = '∙',
        },
    },
    -- terminal = {
    --     -- shell = 'bash',
    -- },
    bigfile = { enabled = true },
    picker = { enabled = false },
    -- notifier = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = false },
    scroll = { enabled = false },
    statuscolumn = {
        enabled = true,

        left = function(win, buf)
            local is_neominimap = vim.bo[buf].filetype == 'neominimap'
            return is_neominimap and {} or { 'mark', 'sign' }
        end,
        right = function(win, buf)
            local is_neominimap = vim.bo[buf].filetype == 'neominimap'
            return is_neominimap and { 'sign', 'git' } or { 'fold', 'git' }
        end,
        refresh = 10,
    },
    words = { enabled = false },
    dashboard = {
        width = 67,
        pane_gap = 10,
        enabled = true,
        preset = {
            keys = {
                {
                    icon = '󰎕 ',
                    key = 'n',
                    desc = 'Neovim News',
                    action = function()
                        Snacks.win({
                            file = vim.api.nvim_get_runtime_file('doc/news.txt', false)[1],
                            width = 0.4,
                            height = 0.6,
                            relative = 'editor',
                            position = 'float',
                            border = 'single',
                            wo = {
                                spell = false,
                                wrap = false,
                                signcolumn = 'yes',
                                statuscolumn = ' ',
                                conceallevel = 3,
                            },
                        })
                    end,
                },
                {
                    icon = '󰆧 ',
                    key = 'u',
                    desc = 'Update Plugins',
                    action = ':lua vim.pack.update()',
                },
                {
                    icon = ' ',
                    key = 'f',
                    desc = 'Find Files',
                    action = ':FzfLua files',
                },
                {
                    icon = '󰱽 ',
                    key = 's',
                    desc = 'Find String',
                    action = ':FzfLua live_grep',
                },
                {
                    icon = '󰄶 ',
                    key = 'b',
                    desc = 'Scratch Buffer',
                    action = ':lua Snacks.scratch()',
                },
                {
                    icon = '󱏒 ',
                    key = 'e',
                    desc = 'Explore files',
                    action = ':lua MiniFiles.open()',
                },
                {
                    icon = ' ',
                    key = 'o',
                    desc = 'Old Files',
                    action = ':FzfLua oldfiles',
                },
                -- {
                --     icon = ' ',
                --     key = 'c',
                --     desc = 'Config',
                --     action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
                -- },

                -- {
                --     icon = ' ',
                --     key = 'g',
                --     desc = 'Git',
                --     action = ':Neogit kind=floating',
                -- },

                -- {
                --     icon = '󱘲 ',
                --     key = 'd',
                --     desc = 'Database',
                --     action = ':Dbee',
                -- },

                -- {
                --     icon = '󱚤 ',
                --     key = 'c',
                --     desc = 'AI Chat',
                --     action = function()
                --         require('codecompanion').toggle()
                --     end,
                -- },

                -- {
                --     icon = ' ',
                --     key = 't',
                --     desc = 'Terminal',
                --     action = function()
                --         vim.cmd([[
                --         terminal
                --         startinsert
                --         ]])
                --     end,
                -- },

                {
                    icon = ' ',
                    key = 'r',
                    desc = 'Restore Session',
                    section = 'session',
                },

                {
                    icon = '󱌣 ',
                    key = 'm',
                    desc = 'Mason',
                    action = ':Mason',
                },

                {
                    icon = ' ',
                    key = 'q',
                    desc = 'Quit',
                    action = ':qa',
                },
            },
            header = [[
                                              88                   
                                              ""                   
                                                                   
8b,dPPYba,   ,adPPYba,  ,adPPYba, 8b       d8 88 88,dPYba,,adPYba, 
88P'   `"8a a8P_____88 a8"     "8a`8b     d8' 88 88P'   "88"    "8a
88       88 8PP""""""" 8b       d8 `8b   d8'  88 88      88      88
88       88 "8b,   ,aa "8a,   ,a8"  `8b,d8'   88 88      88      88
88       88  `"Ybbd8"'  `"YbbdP"'     "8"     88 88      88      88
                ]],
        },
        sections = {
            {
                -- pane = 2,
                -- width = 20,
                { section = 'header', padding = 0 },
                -- {
                --     section = 'terminal',
                --     cmd = 'toilet -f univers -F metal -F crop "neovim"',
                --     indent = -10,
                --     width = 60,
                -- },

                { section = 'keys', gap = 1, padding = 3 },
                -- { section = 'startup', padding = 1 },
                -- {
                --     section = 'terminal',
                --     cmd = 'chafa ~/dl/wide_mountain.png --format symbols --symbols vhalf --size 100x40; sleep .1',
                --     width = 100,
                -- },
            },
            {
                pane = 2,
                -- {
                --     section = 'terminal',
                --     cmd = 'chafa ~/dl/dark_nvim_img.jpg --format symbols --symbols sextant --size 40x28 --align mid,left; sleep .1',
                --     padding = 2,
                --     height = 15,
                -- },
                {
                    -- icon = '',
                    -- title = 'Welcome Back',
                    padding = 2,
                },

                {
                    icon = '',
                    title = 'MRU ',
                    file = vim.fn.fnamemodify('.', ':~'),
                    padding = 1,
                },
                {
                    section = 'recent_files',
                    cwd = true,
                    limit = 3,
                    indent = 2,
                    padding = 2,
                },

                {
                    icon = '',
                    title = 'Projects ',
                    padding = 1,
                },
                {
                    section = 'projects',
                    limit = 3,
                    indent = 2,
                    padding = 2,
                },

                { icon = '', title = 'MRU ', file = '~/', padding = 1 },
                { section = 'recent_files', limit = 3, indent = 2, padding = 2 },

                {
                    icon = '󰊢',
                    title = 'Git Status',
                    padding = 1,
                },
                {
                    indent = 2,
                    padding = 1,
                    section = 'terminal',
                    enabled = function()
                        return Snacks.git.get_root() ~= nil
                    end,
                    cmd = 'git status --short --branch --renames',
                },
            },
        },
    },
})

vim.keymap.set('n', '<leader>fi', function()
    Snacks.picker.icons()
end, { desc = '[F]ind [I]cons' })

vim.keymap.set('n', '<leader>td', function()
    Snacks.toggle.dim():toggle()
end, { desc = '[T]oggle [D]im' })

vim.keymap.set('n', '<leader>sb', function()
    Snacks.scratch()
end, { desc = '[S]cratch [B]uffer' })

vim.keymap.set('n', '<leader>Z', function()
    Snacks.zen()
end, { desc = 'Toggle [Z]en Mode' })
