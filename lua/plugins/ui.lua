return {
    {
        'xiyaowong/nvim-transparent',
        event = 'VimEnter',
        config = function()
            require('transparent').setup({
                extra_groups = {
                    "NormalFloat",
                    "NeoTreeNormal",
                    --"DashboardHeader",
                    --"DashboardFooter",
                    "TreesitterContext",

                }                                            -- mason, lazy, lspinfo
            })
            require('transparent').clear_prefix('Dashboard') -- handles dashboard
            require('transparent').clear_prefix('WhichKey')  -- handles which-key
            -- require('transparent').clear_prefix('LspInfo') -- handles annoying lsp msg
            -- require('transparent').clear_prefix('lualine') -- handles which-key

            vim.keymap.set("n", "<leader>tt", "<cmd>TransparentToggle<CR>")
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
        },
        init = function()
            vim.notify = require("notify")
        end,
        config = function(_, opts)
            require("notify").setup(opts)
        end,
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            lsp = {
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
                hover = { -- set for lsp zero
                    enabled = false,
                },
                signature = { -- set for lsp zero
                    enabled = false,
                },
            },

            views = {
                split = {
                    enter = true,
                },
                cmdline_popup = {
                    position = {
                        row = 5,
                        col = "50%",
                    },
                    size = {
                        width = 60,
                        height = "auto",
                    },
                    border = {
                        style = "none",
                        padding = { 2, 3 },
                    },
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
                        style = "rounded",
                        padding = { 0, 1 },
                    },
                    -- win_options = {
                    --     winhighlight = {
                    --         Normal = "NormalFloat",
                    --         FloatBorder = "FloatBorder",
                    --     },
                    -- },
                },
            },

            -- you can enable a preset for easier configuration
            presets = {
                bottom_search = false,         -- use a classic bottom cmdline for search
                command_palette = false,       -- position the cmdline and popupmenu together
                long_message_to_split = false, -- long messages will be sent to a split
                inc_rename = false,            -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = true,         -- add a border to hover docs and signature help
            },
        },
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            -- "rcarriga/nvim-notify",
        },
        config = function(_, opts)
            require("noice").setup(opts)
        end,
    },
    {                    -- fun scope animations
        "echasnovski/mini.indentscope",
        version = false, -- wait till new 0.7.0 release to put it back on semver
        event = "VeryLazy",
        opts = {
            symbol = "▏",
            -- symbol = "│",
            options = {
                border = "both",
                indent_at_cursor = true,
                try_as_border = true,
            },
        },
        config = function(_, opts)
            require('mini.indentscope').setup(opts)
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
    {
        'tomiis4/BufferTabs.nvim',
        event = "VeryLazy",
        dependencies = {
            'nvim-tree/nvim-web-devicons', -- optional
        },
        -- lazy = false,
        config = function()
            require('buffertabs').setup({
                -- config
            })
            vim.keymap.set("n", "<leader>bt", "<cmd>BufferTabsToggle<CR>")
        end
    },
    { -- bottom line display #TODO Configure
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = {
            options = {
                icons_enabled = true,
                theme = 'auto',
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
                disabled_filetypes = {
                    statusline = {},
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                globalstatus = true,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                }
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'filename', 'branch' },
                lualine_c = { 'buffers' },
                lualine_x = { 'fileformat', 'filetype' },
                lualine_y = {
                    { "encoding", padding = { left = 1, right = 1 } },
                    { "filesize", padding = { left = 1, right = 1 } },
                },
                lualine_z = {
                    function()
                        return " " .. os.date("%R")
                    end,
                },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { 'filename' },
                lualine_x = { 'location' },
                lualine_y = {},
                lualine_z = {}
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {}
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
    --                 close_command = "bdelete! %d",       -- can be a string | function, | false see "Mouse actions"
    --                 right_mouse_command = "bdelete! %d", -- can be a string | function | false, see "Mouse actions"
    --                 left_mouse_command = "buffer %d",    -- can be a string | function, | false see "Mouse actions"
    --                 middle_mouse_command = nil,          -- can be a string | function, | false see "Mouse actions"
    --                 indicator = {
    --                     -- icon = '▎', -- this should be omitted if indicator style is not 'icon'
    --                     style = 'underline', -- 'icon' | 'underline' | 'none',
    --                 },
    --                 buffer_close_icon = '󰅖',
    --                 modified_icon = '●',
    --                 close_icon = '',
    --                 left_trunc_marker = '',
    --                 right_trunc_marker = '',
    --                 offsets = {
    --                     {
    --                         filetype = "NvimTree",
    --                         text = "File Explorer",
    --                         text_align = "left", -- "left" | "center" | "right"
    --                         separator = true,
    --                     },
    --                 },
    --                 color_icons = true, -- whether or not to add the filetype icon highlights
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
