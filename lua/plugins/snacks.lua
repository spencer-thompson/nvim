---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
local progress = vim.defaulttable()
vim.api.nvim_create_autocmd('LspProgress', {
    ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
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

        local msg = {} ---@type string[]
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

return {
    'folke/snacks.nvim',
    name = 'snacks',
    priority = 1000,
    lazy = false,
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        bigfile = { enabled = true },
        notifier = { enabled = true },
        quickfile = { enabled = true },
        statuscolumn = { enabled = false },
        -- words = { enabled = true },
        dashboard = {
            width = 60,
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
                                -- backdrop = 1.0,
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
                                                                    
8b,dPPYba,   ,adPPYba,  ,adPPYba,  8b       d8 88 88,dPYba,,adPYba, 
88P'   `"8a a8P_____88 a8"     "8a `8b     d8' 88 88P'   "88"    "8a
88       88 8PP""""""" 8b       d8  `8b   d8'  88 88      88      88
88       88 "8b,   ,aa "8a,   ,a8"   `8b,d8'   88 88      88      88
88       88  `"Ybbd8"'  `"YbbdP"'      "8"     88 88      88      88
                ]],
            },
            sections = {
                { section = 'header' },
                -- { section = 'terminal', cmd = 'toilet -f univers -F metal -F crop "neovim"' },
                -- { section = 'terminal', cmd = 'toilet -f univers -F metal "spencer" | sed \'1,4 d; s/^/ /\'' },

                { section = 'keys', gap = 1, padding = 1 },
                { section = 'startup' },
            },
        },
        styles = {
            notification = {
                wo = { wrap = true }, -- Wrap notifications
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
        --     {
        --         '<leader>un',
        --         function()
        --             Snacks.notifier.hide()
        --         end,
        --         desc = 'Dismiss All Notifications',
        --     },
        --     {
        --         '<leader>bd',
        --         function()
        --             Snacks.bufdelete()
        --         end,
        --         desc = 'Delete Buffer',
        --     },
        --     {
        --         '<leader>gg',
        --         function()
        --             Snacks.lazygit()
        --         end,
        --         desc = 'Lazygit',
        --     },
        --     {
        --         '<leader>gb',
        --         function()
        --             Snacks.git.blame_line()
        --         end,
        --         desc = 'Git Blame Line',
        --     },
        --     {
        --         '<leader>gB',
        --         function()
        --             Snacks.gitbrowse()
        --         end,
        --         desc = 'Git Browse',
        --     },
        --     {
        --         '<leader>gf',
        --         function()
        --             Snacks.lazygit.log_file()
        --         end,
        --         desc = 'Lazygit Current File History',
        --     },
        --     {
        --         '<leader>gl',
        --         function()
        --             Snacks.lazygit.log()
        --         end,
        --         desc = 'Lazygit Log (cwd)',
        --     },
        --     {
        --         '<leader>cR',
        --         function()
        --             Snacks.rename.rename_file()
        --         end,
        --         desc = 'Rename File',
        --     },
        {
            '<c-/>',
            function()
                Snacks.terminal()
            end,
            desc = 'Toggle Terminal',
        },
        --     {
        --         '<c-_>',
        --         function()
        --             Snacks.terminal()
        --         end,
        --         desc = 'which_key_ignore',
        --     },
        --     {
        --         ']]',
        --         function()
        --             Snacks.words.jump(vim.v.count1)
        --         end,
        --         desc = 'Next Reference',
        --         mode = { 'n', 't' },
        --     },
        --     {
        --         '[[',
        --         function()
        --             Snacks.words.jump(-vim.v.count1)
        --         end,
        --         desc = 'Prev Reference',
        --         mode = { 'n', 't' },
        --     },
        --     {
        --         '<leader>N',
        --         desc = 'Neovim News',
        --         function()
        --             Snacks.win({
        --                 file = vim.api.nvim_get_runtime_file('doc/news.txt', false)[1],
        --                 width = 0.6,
        --                 height = 0.6,
        --                 wo = {
        --                     spell = false,
        --                     wrap = false,
        --                     signcolumn = 'yes',
        --                     statuscolumn = ' ',
        --                     conceallevel = 3,
        --                 },
        --             })
        --         end,
        --     },
    },
}
