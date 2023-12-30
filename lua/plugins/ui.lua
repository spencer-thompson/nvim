return {
    {
        'xiyaowong/nvim-transparent',
        event = 'vimenter',
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
                        style = "single",
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
    -- { -- bottom line display #todo configure
    --     "nvim-lualine/lualine.nvim",
    --     event = "VeryLazy",
    --     opts = {
    --         options = {
    --             icons_enabled = true,
    --             theme = 'auto',
    --             component_separators = { left = '', right = '' },
    --             section_separators = { left = '', right = '' },
    --             disabled_filetypes = {
    --                 statusline = {},
    --                 winbar = {},
    --             },
    --             ignore_focus = {},
    --             always_divide_middle = false,
    --             globalstatus = true,
    --             refresh = {
    --                 statusline = 1000,
    --                 tabline = 1000,
    --                 winbar = 1000,
    --             }
    --         },
    --         sections = {
    --             lualine_a = { 'mode' },
    --             lualine_b = {
    --                 { 'filename' },
    --                 { 'branch' },
    --                 {
    --                     'diagnostics',
    --                     sources = { 'nvim_diagnostic', 'nvim_lsp' },
    --                     sections = { 'error', 'warn', 'info', 'hint' },
    --                     diagnostics_color = {          -- Same values as the general color option can be used here.
    --                         error = 'DiagnosticError', -- Changes diagnostics' error color.
    --                         warn  = 'DiagnosticWarn',  -- Changes diagnostics' warn color.
    --                         info  = 'DiagnosticInfo',  -- Changes diagnostics' info color.
    --                         hint  = 'DiagnosticHint',  -- Changes diagnostics' hint color.
    --                     },
    --                     colored = false,
    --                 },
    --             },
    --             lualine_c = {
    --                 {
    --                     'buffers',
    --                     hide_filename_extension = true,
    --                     filetype_names = {
    --                         telescopeprompt = 'telescope',
    --                         dashboard = 'dashboard',
    --                         packer = 'packer',
    --                         fzf = 'fzf',
    --                         alpha = 'alpha'
    --                     },
    --                     symbols = {
    --                         modified = ' ●', -- text to show when the buffer is modified
    --                         alternate_file = '#', -- text to show to identify the alternate file
    --                         directory = '', -- text to show when the buffer is a directory
    --                     },
    --                 },
    --             },
    --             lualine_x = {
    --                 { 'fileformat' },
    --                 { 'filetype' },
    --                 {
    --                     require("lazy.status").updates,
    --                     cond = require("lazy.status").has_updates,
    --                 },
    --             },
    --             lualine_y = {
    --                 { "encoding", padding = { left = 1, right = 1 } },
    --                 { "filesize", padding = { left = 1, right = 1 } },
    --             },
    --             lualine_z = {
    --                 {
    --                     'datetime',
    --                     style = 'default',
    --                 },
    --             },
    --         },
    --         -- inactive_sections = {
    --         --     lualine_a = {},
    --         --     lualine_b = {},
    --         --     lualine_c = { 'filename' },
    --         --     lualine_x = { 'location' },
    --         --     lualine_y = {},
    --         --     lualine_z = {}
    --         -- },
    --         tabline = {
    --             lualine_a = {
    --                 -- {
    --                 --     'filetype',
    --                 --     colored = false,
    --                 --     icon_only = true,
    --                 -- },
    --                 {
    --                     'filename',
    --                     file_status = true,     -- Displays file status (readonly status, modified status)
    --                     newfile_status = false, -- Display new file status (new file means no write after created)
    --                     path = 0,               -- 0: Just the filename
    --                     -- 1: Relative path
    --                     -- 2: Absolute path
    --                     -- 3: Absolute path, with tilde as the home directory
    --                     -- 4: Filename and parent dir, with tilde as the home directory
    --
    --                     -- shorting_target = 40,    -- Shortens path to leave 40 spaces in the window
    --                     -- for other components. (terrible name, any suggestions?)
    --                     symbols = {
    --                         modified = '[+]',      -- Text to show when the file is modified.
    --                         readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
    --                         unnamed = '[No Name]', -- Text to show for unnamed buffers.
    --                         newfile = '[New]',     -- Text to show for newly created file before first write
    --                     }
    --                 }
    --             },
    --             lualine_b = {
    --                 {
    --                     'buffers',
    --                     hide_filename_extension = true,
    --                     filetype_names = {
    --                         TelescopePrompt = 'Telescope',
    --                         dashboard = 'Dashboard',
    --                         -- packer = 'Packer',
    --                         fzf = 'FZF',
    --                         alpha = 'Alpha',
    --                         lazy = 'Lazy',
    --                     },
    --                     symbols = {
    --                         modified = ' ●', -- text to show when the buffer is modified
    --                         alternate_file = '#', -- text to show to identify the alternate file
    --                         directory = '', -- text to show when the buffer is a directory
    --                     },
    --                 },
    --             },
    --             lualine_c = {},
    --             lualine_x = { 'fileformat' },
    --             lualine_y = {},
    --             lualine_z = { 'fileformat' }
    --         },
    --         winbar = { lualine_a = { 'datetime' } },
    --         -- inactive_winbar = {},
    --         extensions = { "neo-tree", "lazy" }
    --     },
    --     init = function()
    --         vim.g.lualine_laststatus = vim.o.laststatus
    --         if vim.fn.argc(-1) > 0 then
    --             -- set an empty statusline till lualine loads
    --             vim.o.statusline = " "
    --         else
    --             -- hide the statusline on the starter page
    --             vim.o.laststatus = 0
    --         end
    --     end,
    --     config = function(_, opts)
    --         require('lualine').setup(opts)
    --     end,
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
