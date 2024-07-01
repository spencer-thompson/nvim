return {

    -- { 'kyazdani42/nvim-web-devicons', name = 'web-devicons' },

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
        'xiyaowong/nvim-transparent',
        name = 'transparent',
        event = 'VeryLazy',
        config = function()
            require('transparent').setup({
                extra_groups = {
                    'normalfloat',
                    'neotreenormal',
                    --"dashboardheader",
                    --"dashboardfooter",
                    'treesittercontext',
                    'floattitle',
                    'floatborder',
                    'title',
                },                                              -- mason, lazy, lspinfo
            })
            require('transparent').clear_prefix('dashboard')    -- handles dashboard
            require('transparent').clear_prefix('whichkey')     -- handles which-key
            -- require('transparent').clear_prefix('pmenu')     -- handles
            require('transparent').clear_prefix('telescope')    -- handles telescope
            require('transparent').clear_prefix('noicecmdline') -- handles noice
            require('transparent').clear_prefix('gitsigns')
            require('transparent').clear_prefix('diagnosticsign')
            require('transparent').clear_prefix('lualine_c') -- handles lualine
            require('transparent').clear_prefix('lualine_x')
            -- require('transparent').clear_prefix('lspinfo') -- handles annoying lsp msg
            -- require('transparent').clear_prefix('lualine') -- handles which-key
            require('transparent').clear_prefix('foldcolumn') -- handles which-key

            vim.keymap.set('n', '<leader>tr', '<cmd>TransparentToggle<cr>', { desc = 'Transparent' })
        end,
    },

    {
        'kevinhwang91/nvim-ufo',
        name = 'ufo',
        event = 'VeryLazy',
        dependencies = { 'kevinhwang91/promise-async' },
    },

    {
        'RRethy/vim-illuminate',
        name = 'illuminate',
        event = 'VeryLazy',
        lazy = true,
        config = function()
            require('illuminate').configure({
                delay = 200,
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
        event = 'VeryLazy',
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
                        timeout = 1000,
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
                    view_error = "notify",       -- view for errors
                    view_warn = "notify",        -- view for warnings
                    view_history = "messages",   -- view for :messages
                    view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
                },
                views = {
                    notify = {
                        replace = true,
                        merge = true,
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
                        view = 'notify',
                        filter = { event = 'msg_showmode' },
                        opts = { skip = false, stop = false },
                    },
                },

                presets = {                       -- you can enable a preset for easier configuration
                    bottom_search = false,        -- use a classic bottom cmdline for search
                    command_palette = true,       -- position the cmdline and popupmenu together
                    long_message_to_split = true, -- long messages will be sent to a split
                    inc_rename = false,           -- enables an input dialog for inc-rename.nvim
                    lsp_doc_border = true,        -- add a border to hover docs and signature help
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
        lazy = true,
        event = 'VeryLazy',
        config = function()
            require('statuscol').setup({
                setopt = true,
            })
        end,
    },

    -- {
    --     'echasnovski/mini.indentscope',
    --     version = false,
    -- },
    {                  -- fun scope animations
        'echasnovski/mini.indentscope',
        version = '*', -- wait till new 0.7.0 release to put it back on semver
        event = 'VeryLazy',
        config = function()
            local indent_scope = require('mini.indentscope')
            indent_scope.setup({
                symbol = '▏',
                -- symbol = "│",
                options = {
                    border = 'both',
                    indent_at_cursor = true,
                    try_as_border = true,
                },
                draw = {
                    delay = 50,
                    -- animation = require('mini.indentscope').gen_animation.exponential({
                    --     easing = 'out',
                    --     duration = 100,
                    --     unit = 'total',
                    -- })
                },
            })
            indent_scope.gen_animation.exponential({
                easing = 'out',
                duration = 100,
                unit = 'step',
            })
        end,
        init = function()
            vim.api.nvim_create_autocmd('filetype', {
                pattern = {
                    'help',
                    'alpha',
                    'dashboard',
                    'neo-tree',
                    'trouble',
                    'trouble',
                    'lazy',
                    'mason',
                    'notify',
                    'toggleterm',
                    'lazyterm',
                },
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
            })
        end,
    },

    {
        'stevearc/dressing.nvim',
        name = 'dressing',
        lazy = true,
        opts = {},
    },
    -- {
    --     'tomiis4/buffertabs.nvim',
    --     event = "VeryLazy",
    --     dependencies = {
    --         'nvim-tree/nvim-web-devicons', -- optional
    --     },
    --     -- lazy = false,
    --     config = function()
    --         require('buffertabs').setup({
    --             -- config
    --         })
    --         vim.keymap.set("n", "<leader>bt", "<cmd>BufferTabsToggle<cr>")
    --     end
    -- },
    --
    -- {
    --     'akinsho/bufferline.nvim',
    --     version = "*",
    --     dependencies = 'nvim-tree/nvim-web-devicons',
    --     event = "VeryLazy",
    --     config = function()
    --         require('bufferline').setup {
    --             options = {
    --                 mode = "buffers",
    --                 close_command = "bdelete! %d",       -- can be a string | function, | false see "mouse actions"
    --                 right_mouse_command = "bdelete! %d", -- can be a string | function | false, see "mouse actions"
    --                 left_mouse_command = "buffer %d",    -- can be a string | function, | false see "mouse actions"
    --                 middle_mouse_command = nil,          -- can be a string | function, | false see "mouse actions"
    --                 diagnostics = "nvim_lsp",
    --                 -- indicator = {
    --                 --     -- icon = '▎', -- this should be omitted if indicator style is not 'icon'
    --                 --     style = 'underline', -- 'icon' | 'underline' | 'none',
    --                 -- },
    --                 buffer_close_icon = '󰅖',
    --                 modified_icon = '●',
    --                 close_icon = '',
    --                 left_trunc_marker = '',
    --                 right_trunc_marker = '',
    --                 offsets = {
    --                     {
    --                         filetype = "neo-tree",
    --                         text = "Explorer",
    --                         text_align = "left", -- "left" | "center" | "right"
    --                         highlight = "Directory",
    --                         separator = true,
    --                     },
    --                 },
    --                 tab_size = 20,
    --                 color_icons = true,        -- whether or not to add the filetype icon highlights
    --                 always_show_bufferline = true,
    --                 separator_style = "thick", -- "slant", -- | "slope" | "thick" | "thin" | { 'any', 'any' },
    --                 hover = {
    --                     enabled = true,
    --                     delay = 200,
    --                     reveal = { 'close' }
    --                 },
    --             },
    --         }
    --     end,
    -- },
}
