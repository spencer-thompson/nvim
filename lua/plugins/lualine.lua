return {
    { -- bottom line display #todo configure
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = {
            options = {
                icons_enabled = true,
                theme = 'auto',
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
                disabled_filetypes = {
                    statusline = { "dashboard" },
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = false,
                globalstatus = true,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                }
            },
            tabline = {
                lualine_a = {
                    {
                        function()
                            return '  | NEOVIM |  '
                        end,
                        colored = false,
                        icon_only = true,
                    },
                },
                lualine_b = {
                    {
                        'buffers',
                        hide_filename_extension = true,
                        filetype_names = {
                            TelescopePrompt = 'Telescope',
                            dashboard = 'Dashboard',
                            -- packer = 'Packer',
                            fzf = 'FZF',
                            alpha = 'Alpha',
                            lazy = 'Lazy',
                        },
                        symbols = {
                            modified = ' ●', -- text to show when the buffer is modified
                            alternate_file = '#', -- text to show to identify the alternate file
                            directory = '', -- text to show when the buffer is a directory
                        },
                    },
                },
                lualine_c = {},
                lualine_x = {
                    {
                        require("lazy.status").updates,
                        cond = require("lazy.status").has_updates,
                    },
                },
                lualine_y = {
                    { -- todo
                        'tabs',
                    }
                },
                lualine_z = { 'fileformat' }
            },

            winbar = {
                lualine_a = {
                    {
                        'windows',
                        show_filename_only = true,
                        hide_filename_extension = true,
                        show_modified_status = true,
                        mode = 0,
                        filetype_names = {
                            TelescopePrompt = 'Telescope',
                            dashboard = 'Dashboard',
                            -- packer = 'Packer',
                            fzf = 'FZF',
                            alpha = 'Alpha'
                        },

                    },
                },
                lualine_b = {
                    {
                        'diff',
                        symbols = {
                            added = '+ ',
                            modified = '~ ',
                            removed = '- ',
                        },
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
                },
                lualine_c = {
                    {
                        'diagnostics',
                        sources = { 'nvim_diagnostic', 'nvim_lsp' },
                        sections = { 'error', 'warn', 'info', 'hint' },
                        diagnostics_color = {          -- Same values as the general color option can be used here.
                            error = 'DiagnosticError', -- Changes diagnostics' error color.
                            warn  = 'DiagnosticWarn',  -- Changes diagnostics' warn color.
                            info  = 'DiagnosticInfo',  -- Changes diagnostics' info color.
                            hint  = 'DiagnosticHint',  -- Changes diagnostics' hint color.
                        },
                        colored = true,
                    },
                },
                lualine_x = {
                    { function() return '[%L]' end },
                    { 'progress' },
                },
                lualine_y = {
                    {
                        function()
                            if vim.v.hlsearch == 0 then
                                return ''
                            end
                            local last_search = vim.fn.getreg('/')
                            if not last_search or last_search == '' then
                                return ''
                            end
                            local searchcount = vim.fn.searchcount { maxcount = 9999 }
                            return '"' ..
                                last_search .. '" : ' .. '[' .. searchcount.current .. '/' .. searchcount.total .. ']'
                        end,
                    },
                    { "filesize", padding = { left = 1, right = 1 } },
                },
                lualine_z = {
                    {
                        'filetype',
                        fmt = string.upper,
                        colored = false,
                        icon = { align = 'right' },
                    }
                }
            },
            inactive_winbar = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { 'filename' },
                lualine_x = { '%L' },
                lualine_y = {},
                lualine_z = {}
            },

            sections = {
                lualine_a = { 'mode' },
                lualine_b = {
                    { 'branch' },
                },
                lualine_c = {
                    {
                        'buffers',
                        hide_filename_extension = true,
                        filetype_names = {
                            telescopeprompt = 'telescope',
                            dashboard = 'dashboard',
                            packer = 'packer',
                            fzf = 'fzf',
                            alpha = 'alpha'
                        },
                        symbols = {
                            modified = ' ●', -- text to show when the buffer is modified
                            alternate_file = '#', -- text to show to identify the alternate file
                            directory = '', -- text to show when the buffer is a directory
                        },
                    },
                },
                lualine_x = {
                    {
                        function() return require("noice").api.status.command.get() end,
                        cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
                    },
                    -- {
                    --     function() return require("noice").api.status.mode.get() end,
                    --     cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
                    -- },
                },
                lualine_y = {
                    { "encoding", padding = { left = 1, right = 1 } },
                },
                lualine_z = {
                    {
                        'datetime',
                        style = 'default',
                    },
                },
            },
            -- inactive_sections = {
            --     lualine_a = {},
            --     lualine_b = {},
            --     lualine_c = { 'filename' },
            --     lualine_x = { 'location' },
            --     lualine_y = {},
            --     lualine_z = {}
            -- },

            extensions = { "neo-tree", "lazy", "fzf", "fugitive", "mason", "trouble" }

        },
        init = function()
            vim.g.lualine_laststatus = vim.o.laststatus
            if vim.fn.argc(-1) > 0 then
                -- set an empty statusline till lualine loads
                vim.o.statusline = " "
            else
                -- hide the statusline on the starter page
                vim.o.laststatus = 0
            end
        end,
        config = function(_, opts)
            require('lualine').setup(opts)
        end,
    },
}
