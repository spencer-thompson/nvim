local function is_neominimap(arg)
    return vim.bo[arg.buf].filetype == 'neominimap'
end

local function is_not_neominimap(arg)
    return not is_neominimap(arg)
end

return {

    {
        'nvzone/typr',
        enabled = false,
        cmd = 'TyprStats',
        dependencies = 'nvzone/volt',
        opts = {},
    },

    { -- better moving between splits, and resizing
        'mrjones2014/smart-splits.nvim',
        name = 'smart-splits',
        event = 'VeryLazy',
        config = function()
            vim.keymap.set('n', '<C-left>', require('smart-splits').resize_left, { desc = 'Resize Left' })
            vim.keymap.set('n', '<C-down>', require('smart-splits').resize_down, { desc = 'Resize Down' })
            vim.keymap.set('n', '<C-up>', require('smart-splits').resize_up, { desc = 'Resize Up' })
            vim.keymap.set('n', '<C-right>', require('smart-splits').resize_right, { desc = 'Resize Right' })
            -- moving between splits
            vim.keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left, { desc = 'Go Left' })
            vim.keymap.set('n', '<C-j>', require('smart-splits').move_cursor_down, { desc = 'Go Down' })
            vim.keymap.set('n', '<C-k>', require('smart-splits').move_cursor_up, { desc = 'Go Up' })
            vim.keymap.set('n', '<C-l>', require('smart-splits').move_cursor_right, { desc = 'Go Right' })
            -- vim.keymap.set('n', '<C-left>', require('smart-splits').move_cursor_left, { desc = 'Go Left' })
            -- vim.keymap.set('n', '<C-down>', require('smart-splits').move_cursor_down, { desc = 'Go Down' })
            -- vim.keymap.set('n', '<C-up>', require('smart-splits').move_cursor_up, { desc = 'Go Up' })
            -- vim.keymap.set('n', '<C-right>', require('smart-splits').move_cursor_right, { desc = 'Go Right' })
            vim.keymap.set('n', '<C-\\>', require('smart-splits').move_cursor_previous, { desc = 'Go Previous' })
            -- swapping buffers between windows doesn't work I guess
            vim.keymap.set('n', '<C-S-left>', require('smart-splits').swap_buf_left)
            vim.keymap.set('n', '<C-S-down>', require('smart-splits').swap_buf_down)
            vim.keymap.set('n', '<C-S-up>', require('smart-splits').swap_buf_up)
            vim.keymap.set('n', '<C-S-right>', require('smart-splits').swap_buf_right)
        end,
    },

    { -- fancy way to show the keys I am typing
        'siduck/showkeys',
        cmd = 'ShowkeysToggle',
        lazy = true,
        opts = {
            timeout = 1,
            maxkeys = 5,
            -- more opts
        },
    },

    {
        'Bekaboo/dropbar.nvim',
        name = 'dropbar',
        -- event = { 'BufReadPost', 'BufWritePost' },
        enabled = false,
        event = 'VeryLazy',
        -- optional, but required for fuzzy finder support
        dependencies = {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
        },
        opts = {},
    },

    {
        'nvim-lualine/lualine.nvim',
        name = 'lualine',
        event = 'VeryLazy',
        init = function()
            vim.g.lualine_laststatus = vim.o.laststatus
            if vim.fn.argc(-1) > 0 then
                -- set an empty statusline till lualine loads
                vim.o.statusline = ' '
            else
                -- hide the statusline on the starter page
                vim.o.laststatus = 0
            end
        end,
        config = function()
            local code_companion = require('lualine.component'):extend()

            code_companion.processing = false
            code_companion.spinner_index = 1

            local spinner_symbols = {
                '⠋',
                '⠙',
                '⠹',
                '⠸',
                '⠼',
                '⠴',
                '⠦',
                '⠧',
                '⠇',
                '⠏',
            }
            local spinner_symbols_len = 10

            -- Initializer
            function code_companion:init(options)
                code_companion.super.init(self, options)

                local group = vim.api.nvim_create_augroup('CodeCompanionHooks', {})

                vim.api.nvim_create_autocmd({ 'User' }, {
                    pattern = 'CodeCompanionRequest*',
                    group = group,
                    callback = function(request)
                        if request.match == 'CodeCompanionRequestStarted' then
                            self.processing = true
                        elseif request.match == 'CodeCompanionRequestFinished' then
                            self.processing = false
                        end
                    end,
                })
            end

            -- Function that runs every time statusline is updated
            function code_companion:update_status()
                if self.processing then
                    self.spinner_index = (self.spinner_index % spinner_symbols_len) + 1
                    return spinner_symbols[self.spinner_index]
                else
                    return nil
                end
            end

            local empty = require('lualine.component'):extend()
            function empty:draw(default_highlight)
                self.status = ''
                self.applied_separator = ''
                self:apply_highlights(default_highlight)
                self:apply_section_separators()
                return self.status
            end

            local lsp_servers = require('lualine.component'):extend()
            function lsp_servers:init(options)
                options.icon = options.icon or '󰌘'
                options.split = options.split or ', '
                lsp_servers.super.init(self, options)
            end

            function lsp_servers:update_status()
                local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
                local buf_client_names = {}
                for _, client in pairs(buf_clients) do
                    table.insert(buf_client_names, client.name)
                end
                return table.concat(buf_client_names, self.options.split)
            end

            vim.opt.showmode = false

            -- local minimap_extension = require('neominimap.statusline').lualine_default

            local custom_theme = require('lualine.themes.auto')
            custom_theme.normal.c.bg = 'None'

            require('lualine').setup({
                options = {
                    icons_enabled = true,
                    -- theme = 'molokai',
                    theme = custom_theme,
                    component_separators = { left = '│', right = '│' }, -- │
                    -- component_separators = { left = '', right = '' },
                    -- { left = '', right = '' }, { left = '', right = '' }, '|'
                    -- section_separators = { left = '', right = '' },
                    section_separators = { left = '', right = '' },
                    disabled_filetypes = {
                        statusline = { 'dashboard', 'snacks_dashboard' },
                        winbar = { 'dashboard', 'neo-tree' },
                        tabline = { 'dashboard', 'neo-tree', 'nerdtree' },
                    },
                    ignore_focus = {},
                    always_divide_middle = false,
                    globalstatus = true,
                    refresh = {
                        statusline = 100,
                        tabline = 1000,
                        winbar = 1000,
                    },
                },

                sections = {
                    lualine_a = {
                        {
                            'mode',
                            -- separator = { left = '' },
                            padding = { right = 1, left = 1 },
                        },
                        {
                            'macro-recording',
                            fmt = function()
                                local recording_register = vim.fn.reg_recording()
                                if recording_register == '' then
                                    return ''
                                else
                                    return 'Recording @' .. recording_register
                                end
                            end,
                        },
                    },
                    lualine_b = {
                        {
                            'branch',
                            padding = { right = 1, left = 1 },
                        },
                    },
                    lualine_c = {
                        {
                            'diff',
                            symbols = {
                                added = require('icons').shapes.circle.filled .. ' ',
                                modified = require('icons').shapes.circle.dot .. ' ', --'~ ',
                                removed = require('icons').shapes.circle.outline .. ' ',
                            },
                            padding = { right = 1, left = 1 },
                            source = function()
                                local gitsigns = vim.b.gitsigns_status_dict
                                if gitsigns then
                                    return {
                                        added = gitsigns.added,
                                        modified = gitsigns.changed,
                                        removed = gitsigns.removed,
                                    }
                                end
                            end,
                        },
                        {
                            'diagnostics',
                            sources = { 'nvim_diagnostic', 'nvim_lsp' },
                            sections = { 'error', 'warn', 'info', 'hint' },
                            symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' }, --    
                            colored = true,
                            update_in_insert = true,
                        },
                        -- { function() return '' end, draw_empty = true },
                        -- {
                        --     'filename',
                        --     path = 3,
                        --
                        --     symbols = {
                        --         modified = ' ● ', -- text to show when the buffer is modified
                        --         alternate_file = ' # ', -- text to show to identify the alternate file
                        --         directory = '  ', -- text to show when the buffer is a directory
                        --     },
                        -- },
                        -- { function() return '' end, draw_empty = true },
                        -- {
                        --     'buffers',
                        --     hide_filename_extension = true,
                        --     filetype_names = {
                        --         telescopeprompt = 'telescope',
                        --         dashboard = 'dashboard',
                        --         packer = 'packer',
                        --         fzf = 'fzf',
                        --         alpha = 'alpha'
                        --     },
                        --     symbols = {
                        --         modified = ' ●', -- text to show when the buffer is modified
                        --         alternate_file = '#', -- text to show to identify the alternate file
                        --         directory = '', -- text to show when the buffer is a directory
                        --     },
                        -- },
                    },
                    lualine_x = {
                        {
                            code_companion,
                        },
                        {
                            function()
                                if vim.v.hlsearch == 0 then
                                    return ''
                                end
                                local last_search = vim.fn.getreg('/')
                                if not last_search or last_search == '' then
                                    return ''
                                end
                                local searchcount = vim.fn.searchcount({ maxcount = 9999 })
                                return '"'
                                    .. last_search
                                    .. '" : '
                                    .. '['
                                    .. searchcount.current
                                    .. '/'
                                    .. searchcount.total
                                    .. ']'
                            end,
                        },
                        { 'progress' },
                    },
                    lualine_y = {
                        {
                            require('lazy.status').updates,
                            cond = require('lazy.status').has_updates,
                        },
                        {
                            lsp_servers, -- current attached lsp servers
                        },
                    },
                    lualine_z = {
                        {
                            'datetime',
                            style = '%I:%M %p',
                            -- separator = { left = '' },
                            padding = { left = 1, right = 1 },
                        },
                    },
                },

                extensions = { 'neo-tree', 'lazy', 'fzf', 'fugitive', 'mason', 'trouble', 'man' },
            })
        end,
    },

    { -- vscode style tab to show buffers
        'akinsho/bufferline.nvim',
        name = 'bufferline',
        version = '*',
        event = 'VimEnter',
        keys = {
            { '<leader>bp', '<Cmd>BufferLineTogglePin<CR>', desc = 'Toggle Pin' },
            { '<leader>bP', '<Cmd>BufferLineGroupClose ungrouped<CR>', desc = 'Delete Non-Pinned Buffers' },
            { '<leader>bo', '<Cmd>BufferLineCloseOthers<CR>', desc = 'Delete Other Buffers' },
            { '<leader>br', '<Cmd>BufferLineCloseRight<CR>', desc = 'Delete Buffers to the Right' },
            { '<leader>bl', '<Cmd>BufferLineCloseLeft<CR>', desc = 'Delete Buffers to the Left' },
            { '<S-h>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
            { '<S-l>', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
            { '[b', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
            { ']b', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
            { '[B', '<cmd>BufferLineMovePrev<cr>', desc = 'Move buffer prev' },
            { ']B', '<cmd>BufferLineMoveNext<cr>', desc = 'Move buffer next' },
        },
        opts = {
            options = {

                -- themable = true,
                show_close_icon = false,
                show_buffer_close_icons = false,
                indicator = {
                    style = 'underline',
                },
                close_command = function(bufnr)
                    MiniBufremove.delete(bufnr, false)
                end,
                diagnostics = 'nvim_lsp',
                always_show_bufferline = true,
                -- auto_toggle_bufferline = true,
                -- separator_style = 'thin',
                separator_style = { '', '' },
                offsets = {
                    {
                        filetype = 'neo-tree',
                        text = 'Neo-tree',
                        highlight = 'Directory',
                        text_align = 'left',
                    },
                },
            },
            highlights = {
                -- background = {
                --     -- fg = 'none',
                --     bg = {
                --         attribute = 'bg',
                --         highlight = 'Pmenu',
                --     },
                -- },
                fill = {
                    -- fg = {
                    --     attribute = 'bg',
                    --     highlight = 'Normal',
                    -- },
                    bg = {
                        attribute = 'bg',
                        highlight = 'Pmenu',
                    },
                },
            },
        },
        config = function(_, opts)
            require('bufferline').setup(opts)
            vim.cmd([[BufferLineTabRename main]])
            -- vim.cmd([[hi Pmenu guibg=none]])
        end,
    },

    { -- one of my favorite plugins, this shows the minimap on the side
        'Isrothy/neominimap.nvim',
        -- enabled = false,
        name = 'neominimap',
        event = 'VeryLazy',
        lazy = false,
        init = function()
            local todo_comments_handler = {
                name = 'Todo Comment',
                mode = 'sign',
                namespace = vim.api.nvim_create_namespace('neominimap_todo_comment'),
                init = function() end,
                autocmds = {
                    {
                        event = { 'TextChanged', 'TextChangedI' },
                        opts = {
                            callback = function(apply, args)
                                local bufnr = tonumber(args.buf)
                                vim.schedule(function()
                                    apply(bufnr)
                                end)
                            end,
                        },
                    },
                    {
                        event = 'WinScrolled',
                        opts = {
                            callback = function(apply)
                                local winid = vim.api.nvim_get_current_win()
                                if not winid or not vim.api.nvim_win_is_valid(winid) then
                                    return
                                end
                                local bufnr = vim.api.nvim_win_get_buf(winid)
                                vim.schedule(function()
                                    if bufnr and vim.api.nvim_buf_is_valid(bufnr) then
                                        apply(bufnr)
                                    end
                                end)
                            end,
                        },
                    },
                },
                get_annotations = function(bufnr)
                    local ok, _ = pcall(require, 'todo-comments')
                    if not ok then
                        return {}
                    end
                    local ns_id = vim.api.nvim_get_namespaces()['todo-comments']
                    local extmarks = vim.api.nvim_buf_get_extmarks(bufnr, ns_id, 0, -1, {
                        details = true,
                    })
                    local icons = {
                        FIX = ' ',
                        TODO = ' ',
                        HACK = ' ',
                        WARN = ' ',
                        PERF = ' ',
                        NOTE = ' ',
                        TEST = '⏲ ',
                    }
                    local id = { FIX = 1, TODO = 2, HACK = 3, WARN = 4, PERF = 5, NOTE = 6, TEST = 7 }
                    return vim.tbl_map(function(extmark)
                        local detail = extmark[4]
                        local group = detail.hl_group
                        local kind = string.sub(group, 7)
                        local icon = icons[kind]
                        return {
                            lnum = extmark[2],
                            end_lnum = extmark[2],
                            id = id[kind],
                            highlight = 'TodoFg' .. kind, --- You can customize the highlight here.
                            icon = icon,
                            priority = detail.priority,
                        }
                    end, extmarks)
                end,
            }

            vim.api.nvim_create_autocmd('WinEnter', {
                group = vim.api.nvim_create_augroup('minimap', { clear = true }),
                pattern = '*',
                callback = function()
                    require('neominimap').tabRefresh({}, {})
                end,
            })

            vim.g.neominimap = {
                auto_enable = true,
                notification_level = vim.log.levels.OFF,
                layout = 'float',
                delay = 500,
                float = {
                    window_border = 'none',
                    minimap_width = 18,
                    z_index = 1,
                },
                split = {
                    minimap_width = 20,
                    fix_width = true,
                    direction = 'right',
                    close_if_last_window = true,
                },
                click = {
                    enabled = false, -- Enable mouse click on minimap
                    auto_switch_focus = false, -- Automatically switch focus to minimap when clicked
                },
                win_filter = function(winid)
                    local current_winid = vim.api.nvim_get_current_win()
                    return winid == current_winid and vim.fn.winwidth(winid) > 100
                end,
                exclude_filetypes = {
                    'dashboard',
                    'help',
                    'zsh',
                    'kitty-scrollback',
                    'bigfile',
                },
                exclude_buftypes = {
                    'nofile',
                    'nowrite',
                    'quickfix',
                    'terminal',
                    'prompt',
                },
                -- git =
                diagnostic = {
                    enabled = true,
                    severity = vim.diagnostic.severity.WARN,
                    mode = 'sign',
                    priority = {
                        ERROR = 100,
                        WARN = 90,
                        INFO = 80,
                        HINT = 70,
                    },
                },
                -- git = { enabled = true, mode = 'sign' },
                search = { enabled = true, mode = 'sign', priority = 20 },
                mark = { enabled = true, mode = 'sign', priority = 100 },
                -- handlers = {
                --     todo_comments_handler,
                -- },
            }

            vim.keymap.set('n', '<leader>mt', '<cmd>Neominimap toggle<CR>', { desc = 'Toggle Minimap' })
            vim.keymap.set('n', '<leader>mf', '<cmd>Neominimap toggleFocus<CR>', { desc = 'Toggle Minimap Focus' })
        end,
    },

    {
        'mistricky/codesnap.nvim',
        name = 'codesnap',
        build = 'make',
        event = 'VeryLazy',
        enabled = false,
        keys = {
            { '<leader>sc', '<cmd>CodeSnap<cr>', mode = 'x', desc = 'Save selected code snapshot into clipboard' },
            { '<leader>sa', '<cmd>CodeSnapASCII<cr>', mode = 'x', desc = 'Save selected code ASCII into clipboard' },
            -- { "<leader>cs", "<cmd>CodeSnapSave<cr>", mode = "x", desc = "Save selected code snapshot in ~/Pictures" },
        },
        opts = {
            title = 'Neovim',
            code_font_family = 'JetBrainsMono Nerd Font',
        },
    },

    {
        'folke/edgy.nvim',
        name = 'edgy',
        event = 'VeryLazy',
        enabled = false,
        opts = {
            bottom = {
                -- toggleterm / lazyterm at the bottom with a height of 40% of the screen
                {
                    ft = 'toggleterm',
                    size = { height = 0.4 },
                    -- exclude floating windows
                    filter = function(buf, win)
                        return vim.api.nvim_win_get_config(win).relative == ''
                    end,
                },
                'Trouble',
                { ft = 'qf', title = 'QuickFix' },
                {
                    ft = 'help',
                    size = { height = 20 },
                    -- only show help buffers
                    filter = function(buf)
                        return vim.bo[buf].buftype == 'help'
                    end,
                },
                -- { ft = 'spectre_panel', size = { height = 0.4 } },
            },
            left = {
                -- Neo-tree filesystem always takes half the screen height
                {
                    title = 'Neo-Tree',
                    ft = 'neo-tree',
                    filter = function(buf)
                        return vim.b[buf].neo_tree_source == 'filesystem'
                    end,
                    size = { height = 0.5 },
                },
                {
                    title = function()
                        local buf_name = vim.api.nvim_buf_get_name(0) or '[No Name]'
                        return vim.fn.fnamemodify(buf_name, ':t')
                    end,
                    ft = 'Outline',
                    pinned = true,
                    open = 'SymbolsOutlineOpen',
                },
                -- any other neo-tree windows
                'neo-tree',
            },
        },
    },

    { -- fancy ui like floating search and command
        'folke/noice.nvim',
        -- enabled = false,
        name = 'noice',
        event = 'VimEnter',
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            { 'MunifTanjim/nui.nvim', name = 'nui' },
        },
        config = function()
            if vim.o.filetype == 'lazy' then
                vim.cmd([[messages clear]])
            end
            require('noice').setup({
                messages = {
                    enabled = true,
                    view = 'notify',
                    view_error = 'notify', -- view for errors
                    view_warn = 'notify', -- view for warnings
                    view_history = 'messages', -- view for :messages
                    view_search = 'virtualtext', -- view for search count messages. Set to `false` to disable
                },
                views = {
                    notify = {
                        replace = true,
                        merge = false,
                    },
                    hover = {
                        border = {
                            style = 'single', -- double, none, rounded, shadow, single, solid
                        },
                    },
                    popupmenu = {
                        border = {
                            style = 'single',
                        },
                    },
                    popup = {
                        border = {
                            style = 'single',
                        },
                    },
                    cmdline_popup = {
                        border = {
                            style = 'single',
                        },
                    },
                },

                lsp = {
                    progress = {
                        enabled = false,
                        -- format = 'lsp_progress',
                        format_done = 'lsp_progress_done',
                        -- throttle = 5000 / 30,
                        view = 'notify',
                    },
                    -- override markdown rendering so that **cmp** and other plugins use **treesitter**
                    override = {
                        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
                        ['vim.lsp.util.stylize_markdown'] = true,
                        ['cmp.entry.get_documentation'] = true,
                    },
                    -- hover = { enabled = false },
                    -- signature = { enabled = false },
                },
                routes = {
                    {
                        filter = {
                            event = 'msg_show',
                            any = {
                                { find = '%d+L, %d+B' },
                                { find = '; after #%d+' },
                                { find = '; before #%d+' },
                            },
                        },
                        opts = { timeout = 500 },
                        view = 'mini',
                    },
                    {
                        filter = {
                            event = 'msg_show',
                            kind = 'search_count',
                        },
                        opts = { skip = true },
                    },
                    {
                        filter = {
                            event = 'lsp',
                            kind = 'progress',
                            cond = function(message)
                                local client = vim.tbl_get(message.opts, 'progress', 'client')
                                return client == 'lua_ls'
                            end,
                        },
                        opts = { skip = true },
                    },
                    {
                        view = 'mini',
                        opts = { timeout = 5000 },
                        filter = { find = '(mini.align)' },
                    },
                    {
                        filter = {
                            find = 'All parsers',
                        },
                        opts = { skip = true },
                    },
                },

                presets = { -- you can enable a preset for easier configuration
                    bottom_search = false, -- use a classic bottom cmdline for search
                    command_palette = true, -- position the cmdline and popupmenu together
                    long_message_to_split = true, -- long messages will be sent to a split
                    inc_rename = false, -- enables an input dialog for inc-rename.nvim
                    lsp_doc_border = true, -- add a border to hover docs and signature help
                },
            })

            vim.keymap.set({ 'n', 'i', 's' }, '<c-u>', function()
                if not require('noice.lsp').scroll(-4) then
                    return '<c-u>'
                end -- scroll up
            end, { silent = true, expr = true })

            vim.keymap.set({ 'n', 'i', 's' }, '<c-d>', function()
                if not require('noice.lsp').scroll(4) then
                    return '<c-d>'
                end -- scroll down
            end, { silent = true, expr = true })
        end,
    },

    {
        'luukvbaal/statuscol.nvim',
        name = 'statuscol',
        enabled = false,
        event = { 'BufNewFile', 'BufReadPre' },
        -- event = 'VeryLazy',
        opts = function()
            vim.api.nvim_set_hl(0, 'CursorLineNr', { link = 'ModeMsg' })
            local builtin = require('statuscol.builtin')
            return {
                relculright = true,
                setopt = true,
                segments = {
                    {
                        sign = {
                            name = {
                                'Dap',
                                'neotest',
                            },
                            maxwidth = 2,
                            colwidth = 2,
                            auto = true,
                        },
                        click = 'v:lua.ScSa',
                        condition = { is_not_neominimap },
                    },
                    -- { sign = { name = { 'todo*' }, namespace = { 'diagnostic/signs' }, maxwidth = 1, auto = false } },
                    {
                        text = { builtin.foldfunc, auto = true },
                        condition = { is_not_neominimap },
                    }, -- , click = 'v:lua.ScLa' },
                    { text = { ' ' }, condition = { is_not_neominimap } },
                    {
                        sign = {
                            namespace = { '.*' },
                            name = { '.*' },
                            text = { '.*' },
                            maxwidth = 1,
                            colwidth = 1,
                            auto = false,
                        },
                        click = 'v:lua.ScSa',
                        condition = { is_not_neominimap },
                    },
                    -- { text = { builtin.lnumfunc, builtin.foldfunc }, click = 'v:lua.ScLa' },
                    {
                        text = { builtin.lnumfunc, ' ' },
                        click = 'v:lua.ScLa',
                        condition = { is_not_neominimap },
                    },
                    {
                        sign = {
                            namespace = { 'gitsigns_' },
                            maxwidth = 1,
                            colwidth = 1,
                            auto = false,
                            fillchar = ' ',
                            fillcharhl = 'StatusColumnSeparator',
                        },
                        click = 'v:lua.ScSa',
                        condition = { is_not_neominimap },
                    },
                    {
                        sign = {
                            namespace = { 'neominimap_*' },
                            maxwidth = 1,
                            colwidth = 1, -- For more compact look
                        },
                        condition = { is_neominimap },
                    },
                    -- {
                    --     sign = {
                    --         namespace = { 'neominimap_git' },
                    --         maxwidth = 1,
                    --         colwidth = 1,
                    --     },
                    --     condition = { is_neominimap },
                    -- },
                    -- { text = { ' ' } },
                },
                ft_ignore = {
                    'help',
                    'vim',
                    'fugitive',
                    'alpha',
                    'dashboard',
                    'neo-tree',
                    'Trouble',
                    'noice',
                    'lazy',
                    'toggleterm',
                },
            }
        end,
    },

    -- {
    --     'stevearc/dressing.nvim',
    --     name = 'dressing',
    --     lazy = true,
    --     opts = {},
    -- },
}
