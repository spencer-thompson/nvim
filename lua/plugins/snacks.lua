---@module "snacks"
local progress = vim.defaulttable()
vim.api.nvim_create_autocmd('LspProgress', {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local value = ev.data.params.value
        if not client or type(value) ~= 'table' then
            return
        end
        local p = progress[client.id]

        for i = 1, #p + 1 do
            if i == #p + 1 or p[i].token == ev.data.params.token then
                p[i] = {
                    token = ev.data.params.token,
                    msg = ('[%3d%%] %s%s'):format(
                        value.kind == 'end' and 100 or value.percentage or 100,
                        value.title or '',
                        value.message and (' **%s**'):format(value.message) or ''
                    ),
                    done = value.kind == 'end',
                }
                break
            end
        end

        local msg = {}
        progress[client.id] = vim.tbl_filter(function(v)
            return table.insert(msg, v.msg) or not v.done
        end, p)

        local spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' }
        vim.notify(table.concat(msg, '\n'), 'info', {
            id = 'lsp_progress',
            title = client.name,
            opts = function(notif)
                notif.icon = #progress[client.id] == 0 and ' '
                    or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
            end,
        })
    end,
})

vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniFilesActionRename',
    callback = function(event)
        Snacks.rename.on_rename_file(event.data.from, event.data.to)
    end,
})

-- vim.api.nvim_create_autocmd('QuitPre', { -- closes terminal if open on exit
--     group = vim.api.nvim_create_augroup('close_terminal_on_exit', { clear = true }),
--     desc = 'Close Terminal on Exit',
--     pattern = '*',
--     callback = function()
--         Snacks.terminal.get()[1]:close()
--     end,
-- })

return {
    'folke/snacks.nvim',
    name = 'snacks',
    priority = 1000,
    lazy = false,
    opts = {
        dim = {
            animate = {
                easing = 'outQuart',
                duration = {
                    step = 10,
                    total = 200,
                },
            },
        },
        scroll = { enabled = false, animate = { duration = { step = 2, total = 100 } } },
        indent = {
            enabled = true,
            animate = {
                -- enabled = vim.fn.has('nvim-0.10') == 1,
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
        -- scope = { enabled = true },
        bigfile = { enabled = true },
        notifier = { enabled = true },
        quickfile = { enabled = true },
        statuscolumn = {
            enabled = true,
            left = function(win, buf)
                local is_neominimap = vim.bo[buf].filetype == 'neominimap'
                return is_neominimap and { 'sign' } or { 'mark', 'sign' }
            end,
            right = function(win, buf)
                local is_neominimap = vim.bo[buf].filetype == 'neominimap'
                return is_neominimap and { 'git' } or { 'fold', 'git' }
            end,
        },
        -- words = { enabled = true },
        dashboard = {
            width = 50,
            pane_gap = 10,
            enabled = true,
            preset = {
                keys = {
                    { icon = ' ', key = 'f', desc = 'Find File', action = ":lua Snacks.dashboard.pick('files')" },
                    {
                        icon = '󰎕 ',
                        key = 'n',
                        desc = 'Neovim News',
                        action = function()
                            Snacks.win({
                                file = vim.api.nvim_get_runtime_file('doc/news.txt', false)[1],
                                width = 0.6,
                                height = 0.6,
                                relative = 'editor',
                                position = 'float',
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
                        icon = '󰱽 ',
                        key = 's',
                        desc = 'Find String',
                        action = ":lua Snacks.dashboard.pick('live_grep')",
                    },

                    { icon = '󱏒 ', key = 'e', desc = 'Explore files', action = ':lua MiniFiles.open()' },
                    {
                        icon = ' ',
                        key = 'r',
                        desc = 'Recent Files',
                        action = ":lua Snacks.dashboard.pick('oldfiles')",
                    },
                    {
                        icon = ' ',
                        key = 'c',
                        desc = 'Config',
                        action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
                    },

                    {
                        icon = ' ',
                        key = 'g',
                        desc = 'Git',
                        action = ':Neogit kind=floating',
                    },

                    {
                        icon = '󱘲 ',
                        key = 'd',
                        desc = 'Database',
                        action = ':Dbee',
                    },
                    { icon = ' ', key = 'r', desc = 'Restore Session', section = 'session' },
                    {
                        icon = '󰒲 ',
                        key = 'l',
                        desc = 'Lazy',
                        action = ':Lazy',
                        enabled = package.loaded.lazy ~= nil,
                    },

                    { icon = '󱌣 ', key = 'm', desc = 'Mason', action = ':Mason' },
                    { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
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
            -- formats = {
            -- terminal = { '%s', align = 'center' },
            -- header = { '%s', align = 'left' },
            -- },
            sections = {
                {
                    -- pane = 2,
                    -- width = 20,
                    { section = 'header', padding = 2 },
                    -- {
                    --     section = 'terminal',
                    --     cmd = 'toilet -f univers -F metal -F crop "neovim"',
                    --     indent = -10,
                    --     width = 60,
                    -- },

                    { section = 'keys', gap = 1, padding = 2 },
                    { section = 'startup', padding = 1 },
                    -- {
                    --     section = 'terminal',
                    --     cmd = 'chafa ~/dl/wide_mountain.png --format symbols --symbols vhalf --size 100x40; sleep .1',
                    --     width = 100,
                    -- },
                },
                {
                    pane = 2,
                    {
                        section = 'terminal',
                        cmd = 'chafa ~/dl/test_img.jpeg --format symbols --symbols sextant --size 40x28 --align mid,left; sleep .1',
                        padding = 2,
                        height = 15,
                    },
                    { icon = '', title = 'MRU ', file = vim.fn.fnamemodify('.', ':~'), padding = 1 },
                    { section = 'recent_files', cwd = true, limit = 3, indent = 2, padding = 1 },

                    { icon = '', title = 'Projects ', padding = 1 },
                    { section = 'projects', limit = 3, indent = 2, padding = 1 },

                    { icon = '', title = 'MRU ', padding = 1 },
                    { section = 'recent_files', cwd = true, limit = 3, indent = 2, padding = 1 },

                    -- { section = 'session', padding = 1 },

                    {
                        section = 'terminal',
                        -- cmd = 'fortune -s | fmt -w 60',
                        cmd = 'fortune -s | fmt -w 50',
                        hl = 'comment',
                        -- padding = 1,
                        -- width = 80,
                        -- indent = -2,
                        -- align = 'center',
                    },
                },
                -- {
                --     -- width = 40,
                --     -- align = 'right',
                --     {
                --         section = 'terminal',
                --         cmd = 'chafa ~/dl/ComfyUI_temp_llcpe_00001_.png --format symbols --symbols vhalf --size 40x40; sleep .1',
                --         height = 30,
                --     },
                --     {
                --         section = 'terminal',
                --         -- cmd = 'fortune -s | fmt -w 60',
                --         cmd = 'fortune -s | fmt -w 40 -s',
                --         hl = 'comment',
                --         -- padding = 1,
                --         -- width = 80,
                --         -- indent = -2,
                --         -- align = 'center',
                --     },
                -- },
            },
        },
        styles = {
            notification_history = {
                border = 'single',
            },
            scratch = {
                border = 'single',
            },
            notification = {
                wo = { wrap = true }, -- Wrap notifications
                border = 'single',
            },
            terminal = {
                wo = {
                    -- cursorcolumn = false,
                    -- cursorline = false,
                    -- cursorlineopt = "both",
                    -- fillchars = "eob: ,lastline:…",
                    -- list = false,
                    -- listchars = "extends:…,tab:  ",
                    -- number = false,
                    -- relativenumber = false,
                    -- signcolumn = "no",
                    -- spell = false,
                    winbar = '',
                    -- statuscolumn = "",
                    -- wrap = false,
                    -- sidescrolloff = 0,
                },
            },
        },
    },
    keys = {
        {
            '<leader>nn',
            function()
                Snacks.notifier.hide()
            end,
            desc = 'Dismiss [N]otifications',
        },
        {
            '<leader>nh',
            function()
                Snacks.notifier.show_history()
            end,
            desc = '[N]otification [H]istory',
        },
        -- {
        --     '<leader>bd',
        --     function()
        --         Snacks.bufdelete()
        --     end,
        --     desc = 'Delete Buffer',
        -- },
        {
            '<leader>gg',
            function()
                Snacks.lazygit()
            end,
            desc = 'Lazygit',
        },
        {
            '<leader>gb',
            function()
                Snacks.git.blame_line()
            end,
            desc = 'Git Blame Line',
        },
        {
            '<leader>dm',
            function()
                Snacks.toggle.dim():toggle()
            end,
            desc = 'Toggle Dim',
        },
        {
            '<leader>sb',
            function()
                Snacks.scratch()
            end,
            desc = '[Sc]ratch Buffer',
        },
        {
            '<leader>Z',
            function()
                Snacks.zen()
            end,
            desc = 'Toggle [Z]en Mode',
        },
        {
            '<leader>gl',
            function()
                Snacks.lazygit.log()
            end,
            desc = 'Lazygit Log (cwd)',
        },
        {
            '<c-/>',
            function()
                Snacks.terminal()
            end,
            desc = 'Toggle Terminal',
        },
        {
            '<leader>tt',
            function()
                Snacks.terminal()
            end,
            desc = '[T]oggle [T]erminal',
        },
        {
            '<leader>sh',
            function()
                Snacks.notifier.show_history()
            end,
            desc = '[S]how [H]istory',
        },
        {
            ']]',
            function()
                Snacks.words.jump(vim.v.count1)
            end,
            desc = 'Next Reference',
            mode = { 'n', 't' },
        },
        {
            '[[',
            function()
                Snacks.words.jump(-vim.v.count1)
            end,
            desc = 'Prev Reference',
            mode = { 'n', 't' },
        },
    },
}
