return {
    {
        'xiyaowong/nvim-transparent',
        event = 'VimEnter',
        config = function()
            require('transparent').setup({
                extra_groups = {
                    "normalfloat",
                    "neotreenormal",
                    --"dashboardheader",
                    --"dashboardfooter",
                    "treesittercontext",
                    "floattitle",
                    "floatborder",
                    "title"
                }                                               -- mason, lazy, lspinfo
            })
            require('transparent').clear_prefix('dashboard')    -- handles dashboard
            require('transparent').clear_prefix('whichkey')     -- handles which-key
            -- require('transparent').clear_prefix('pmenu')     -- handles
            require('transparent').clear_prefix('telescope')    -- handles telescope
            require('transparent').clear_prefix('noicecmdline') -- handles noice
            require('transparent').clear_prefix('gitsigns')
            require('transparent').clear_prefix('diagnosticsign')
            -- require('transparent').clear_prefix('lualine_c')    -- handles lualine
            -- require('transparent').clear_prefix('lualine_x')
            -- require('transparent').clear_prefix('lspinfo') -- handles annoying lsp msg
            -- require('transparent').clear_prefix('lualine')   -- handles which-key

            vim.keymap.set("n", "<leader>tt", "<cmd>TransparentToggle<cr>")
        end,
    },
    {
        "rcarriga/nvim-notify",
        event = "VeryLazy",
        opts = {
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
            render = "wrapped-compact",
            fps = 60,
        },
        -- init = function()
        --     vim.notify = require("notify")
        -- end,
        config = function(_, opts)
            require("notify").setup(opts)
        end,
    },
    {
        "RRethy/vim-illuminate",
        event = "VeryLazy",
        config = function()
            require('illuminate').configure({
                delay = 200,
                large_file_cutoff = 2000,
                large_file_overrides = {
                    providers = { "lsp" },
                },
            })

            -- change the highlight style
            vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
            vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
            vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })
        end
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            lsp = {
                -- override markdown rendering so that **cmp** and other plugins use **treesitter**
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
                --     hover = {enabled = false },
                --     signature = { enabled = false },
            },
            routes = {
                {
                    filter = {
                        event = "msg_show",
                        kind = "search_count",
                    },
                    opts = { skip = true },
                },
            },

            views = {
                split = {
                    enter = true,
                },
                cmdline_popup = {
                    position = {
                        row = 10,
                        col = "50%",
                    },
                    size = {
                        width = 80,
                        height = "auto",
                    },
                    border = {
                        style = "none",
                        padding = { 2, 3 },
                    },
                    win_options = {
                        winhighlight = {
                            Normal = "Normal",
                            FloatBorder = "FloatBorder",
                        }
                    }
                },
                popupmenu = {
                    relative = "editor",
                    position = {
                        row = 8,
                        col = "50%",
                    },
                    size = {
                        width = 60,
                        height = 10,
                    },
                    border = {
                        style = "single",
                        padding = { 0, 1 },
                    },
                    win_options = {
                        winhighlight = {
                            Normal = "Normal",
                            FloatBorder = "DiagnosticInfo",
                        },
                    },
                },
                lsp = {
                    progress = {
                        enabled = true,
                        format = "lsp_progress",
                        format_done = "lsp_progress_done",
                    }
                }
            },

            -- you can enable a preset for easier configuration
            presets = {
                bottom_search = false,        -- use a classic bottom cmdline for search
                command_palette = true,       -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = true,            -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = true,        -- add a border to hover docs and signature help
            },
        },
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "muniftanjim/nui.nvim",
            -- optional:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   if not available, we use `mini` as the fallback
            -- "rcarriga/nvim-notify",
        },
        config = function(_, opts)
            require("noice").setup(opts)
        end,
    },
    {                  -- fun scope animations
        "echasnovski/mini.indentscope",
        version = '*', -- wait till new 0.7.0 release to put it back on semver
        event = "VeryLazy",
        opts = {
            symbol = "▏",
            -- symbol = "│",
            options = {
                border = "both",
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
            }
        },
        config = function(_, opts)
            local indent_scope = require('mini.indentscope')
            indent_scope.setup(opts)
            indent_scope.gen_animation.exponential({
                easing = 'out',
                duration = 100,
                unit = 'step',
            })
        end,
        init = function()
            vim.api.nvim_create_autocmd("filetype", {
                pattern = {
                    "help",
                    "alpha",
                    "dashboard",
                    "neo-tree",
                    "trouble",
                    "trouble",
                    "lazy",
                    "mason",
                    "notify",
                    "toggleterm",
                    "lazyterm",
                },
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
            })
        end,
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
    {
        "stevearc/dressing.nvim",
        lazy = true,
        opts = {},
    },
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
    {
        "luukvbaal/statuscol.nvim",
        lazy = true,
        event = "VeryLazy",
        config = function()
            require("statuscol").setup {
                setopt = true,
            }
        end,
    },
    {
        'folke/which-key.nvim',
        event = 'VeryLazy',
        lazy = true,
        opts = {},
        config = function(opts)
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require('which-key').setup(opts)
        end,
    },
}
