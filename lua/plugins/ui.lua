return {

    {
        'shellRaining/hlchunk.nvim',
        name = 'hlchunk',
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
            require('hlchunk').setup({
                chunk = {
                    enable = true,
                    chars = {
                        horizontal_line = '─',
                        vertical_line = '│',
                        -- left_top = '┌',
                        left_top = '╭',
                        -- left_bottom = '└',
                        left_bottom = '╰',
                        right_arrow = '─',
                    },
                    style = '#292e42',
                    duration = 150,
                    delay = 50,
                },
                indent = { enable = false },
            })
        end,
    },

    -- { 'nvchad/volt', lazy = true },
    -- { 'nvchad/minty', lazy = true },
    -- require("minty.huefy").open()
    -- require("minty.shades").open()

    {
        'nvim-lualine/lualine.nvim',
        name = 'lualine',
        event = 'VeryLazy',
        -- init = function()
        --     vim.g.lualine_laststatus = vim.o.laststatus
        --     if vim.fn.argc(-1) > 0 then
        --         -- set an empty statusline till lualine loads
        --         vim.o.statusline = " "
        --     else
        --         -- hide the statusline on the starter page
        --         vim.o.laststatus = 0
        --     end
        -- end,
    },

    {
        'akinsho/bufferline.nvim',
        name = 'bufferline',
        version = '*',
        dependencies = 'nvim-tree/nvim-web-devicons',
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
                indicator = {
                    style = 'underline',
                },
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
        },
        config = function(_, opts)
            require('bufferline').setup(opts)
            vim.cmd([[BufferLineTabRename main]])
        end,
    },

    {
        'Isrothy/neominimap.nvim',
        name = 'neominimap',
        event = 'VeryLazy',
        lazy = false,
        init = function()
            vim.api.nvim_create_autocmd('WinEnter', {
                group = vim.api.nvim_create_augroup('minimap', { clear = true }),
                pattern = '*',
                callback = function()
                    require('neominimap').tabRefresh({}, {})
                end,
            })

            vim.g.neominimap = {
                auto_enable = true,
                layout = 'split',
                float = {
                    -- margin = {
                    --     right = 0,
                    -- },
                    window_border = 'none',
                    minimap_width = 20,
                },
                split = {
                    minimap_width = 20,
                    fix_width = true,
                    direction = 'right',
                    close_if_last_window = true,
                },
                click = {
                    enabled = true, -- Enable mouse click on minimap
                    auto_switch_focus = true, -- Automatically switch focus to minimap when clicked
                },
                buf_filter = function(bufnr)
                    return not vim.api.nvim_get_option_value('wrap', {})
                end,
                win_filter = function(winid)
                    return winid == vim.api.nvim_get_current_win()
                end,
                exclude_filetypes = {
                    'dashboard',
                    'help',
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
                git = { enabled = true, mode = 'sign' },
                search = { enabled = true, mode = 'sign', priority = 20 },
                mark = { enabled = true, mode = 'sign', priority = 100 },
            }

            -- require('neominimap').setup()

            vim.keymap.set('n', '<leader>mt', '<cmd>Neominimap toggle<CR>', { desc = 'Toggle Minimap' })
            vim.keymap.set('n', '<leader>mf', '<cmd>Neominimap toggleFocus<CR>', { desc = 'Toggle Minimap Focus' })
        end,
    },

    {
        'OXY2DEV/markview.nvim',
        lazy = false,
        enabled = false,
        config = function()
            require('markview').setup({
                modes = { 'n', 'i', 'no', 'c' },
                hybrid_modes = { 'i' },

                -- This is nice to have
                callbacks = {
                    on_enable = function(_, win)
                        vim.wo[win].conceallevel = 2
                        vim.wo[win].concealcursor = 'nc'
                    end,
                },
            })

            vim.keymap.set('n', '<leader>mv', '<cmd>Markview<CR>', { desc = 'Render Markdown' })
        end,
    },

    {
        'mistricky/codesnap.nvim',
        name = 'codesnap',
        build = 'make',
        event = 'VeryLazy',
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

    {
        'xiyaowong/nvim-transparent',
        name = 'transparent',
        enabled = false,
        event = 'VimEnter',
        config = function()
            require('transparent').setup({
                extra_groups = {
                    'normalfloat',
                    'neotreenormal',
                    -- 'dashboardheader',
                    --"dashboardfooter",
                    'treesittercontext',
                    'floattitle',
                    'floatborder',
                    'title',
                }, -- mason, lazy, lspinfo
            })
            require('transparent').clear_prefix('dashboard') -- handles dashboard
            require('transparent').clear_prefix('whichkey') -- handles which-key require('transparent').clear_prefix('pmenu')     -- handles
            require('transparent').clear_prefix('telescope') -- handles telescope
            require('transparent').clear_prefix('noicecmdline') -- handles noice
            require('transparent').clear_prefix('gitsigns')
            require('transparent').clear_prefix('diagnosticsign')
            require('transparent').clear_prefix('lualine_c') -- handles lualine
            require('transparent').clear_prefix('lualine_x')
            -- require('transparent').clear_prefix('lspinfo') -- handles annoying lsp msg
            -- require('transparent').clear_prefix('lualine') -- handles which-key
            require('transparent').clear_prefix('foldcolumn') -- handles which-key
            require('transparent').clear_prefix('Noice') -- handles noice
            require('transparent').clear_prefix('mini') -- handles mini stuff
            require('transparent').clear_prefix('Notify') -- handles mini stuff
            require('transparent').clear_prefix('WhichKey') -- handles which-key

            vim.keymap.set('n', '<leader>tr', '<cmd>TransparentToggle<cr>', { desc = 'Transparent' })
        end,
    },

    -- {
    --     'kevinhwang91/nvim-ufo',
    --     name = 'ufo',
    --     event = 'VeryLazy',
    --     dependencies = { 'kevinhwang91/promise-async' },
    -- },

    {
        'RRethy/vim-illuminate',
        name = 'illuminate',
        event = 'VeryLazy',
        enabled = false,
        lazy = true,
        config = function()
            require('illuminate').configure({
                delay = 1000,
                large_file_cutoff = 2000,
                large_file_overrides = {
                    providers = { 'lsp' },
                },
            })

            -- change the highlight style
            vim.api.nvim_set_hl(0, 'IlluminatedWordText', { link = 'Visual' })
            vim.api.nvim_set_hl(0, 'IlluminatedWordRead', { link = 'Visual' })
            vim.api.nvim_set_hl(0, 'IlluminatedWordWrite', { link = 'Visual' })
        end,
    },

    {
        'folke/noice.nvim',
        name = 'noice',
        event = 'VimEnter',
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            { 'MunifTanjim/nui.nvim', name = 'nui' },
            {
                'rcarriga/nvim-notify',
                name = 'notify',
                event = 'VeryLazy',
                priority = 20,
                config = function()
                    require('notify').setup({
                        timeout = 2000,
                        max_height = function()
                            return math.floor(vim.o.lines * 0.75)
                        end,
                        max_width = function()
                            return math.floor(vim.o.columns * 0.75)
                        end,
                        on_open = function(win)
                            vim.api.nvim_win_set_config(win, { zindex = 100 })
                        end,
                        render = 'compact',
                        stages = 'slide',
                        fps = 100, -- my monitor fps
                    })
                end,
            },
        },
        config = function()
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
                },
                lsp = {
                    progress = {
                        enabled = true,
                        format = 'lsp_progress',
                        format_done = 'lsp_progress_done',
                        throttle = 5000 / 30,
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
                            kind = 'search_count',
                        },
                        opts = { skip = true },
                    },
                    {
                        filter = {
                            event = 'msg_show',
                            kind = '',
                            find = 'written',
                        },
                        opts = { skip = true },
                    },
                    {
                        view = 'notify', -- some
                        filter = { event = 'msg_showmode' },
                        opts = { skip = true, stop = false },
                    },
                    -- {
                    --     filter = {
                    --         event = 'msg_show',
                    --         kind = 'echo',
                    --     },
                    --     view = 'cmdline_output',
                    -- },
                    -- {
                    --     filter = {
                    --         event = 'msg_show',
                    --         min_height = 5,
                    --     },
                    --     view = 'split',
                    -- },
                    -- {
                    --     filter = {
                    --         event = 'msg_show',
                    --         min_length = 50,
                    --     },
                    --     view = 'split',
                    -- },
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
        enabled = true,
        -- lazy = true,
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
                    },
                    -- { sign = { name = { 'todo*' }, namespace = { 'diagnostic/signs' }, maxwidth = 1, auto = false } },
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
                    },
                    { text = { ' ' } },
                    { text = { builtin.lnumfunc, builtin.foldfunc }, click = 'v:lua.ScLa' },
                    { text = { ' ' } },
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
                    },
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

    {
        'stevearc/dressing.nvim',
        name = 'dressing',
        lazy = true,
        opts = {},
    },
}
