return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.5',
        -- or                              , branch = '0.1.x',
        event = 'VeryLazy',
        -- priority = 100,
        dependencies = {

            "nvim-telescope/telescope-file-browser.nvim",
            "nvim-telescope/telescope-hop.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                -- NOTE: If you are having trouble with this installation,
                --       refer to the README for telescope-fzf-native for more instructions.
                build = 'make',
                cond = function()
                    return vim.fn.executable 'make' == 1
                end,
            },
        },


        config = function()
            local actions = require("telescope.actions")
            local builtin = require('telescope.builtin')
            local browser = require('telescope').extensions.file_browser


            require('telescope').setup {
                defaults = {
                    prompt_prefix = '> ',
                    selection_caret = '> ',
                    entry_prefix = '  ',
                    multi_icon = '<>',
                    sorting_strategy = "ascending",
                    layout_config = {
                        width = 0.95,
                        height = 0.85,

                        prompt_position = "top",
                        horizontal = {
                            preview_width = function(_, cols, _)
                                if cols > 200 then
                                    return math.floor(cols * 0.4)
                                else
                                    return math.floor(cols * 0.6)
                                end
                            end,
                        },
                        vertical = {
                            width = 0.9,
                            height = 0.95,
                            preview_height = 0.5,
                        },
                        flex = {
                            horizontal = {
                                preview_width = 0.9,
                            },
                        },
                    },

                    mappings = {
                        n = {
                            ['<C-h>'] = browser.actions.goto_home_dir,
                        },
                        i = {
                            ['<Esc>'] = actions.close,
                            ['<C-a>'] = actions.toggle_all,
                            ['<C-u>'] = false,
                            ['<C-d>'] = false,
                            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
                            ["<C-j>"] = actions.move_selection_next,     -- move to next result
                            ['<C-x>'] = browser.actions.remove,
                            ['<C-r>'] = browser.actions.rename,


                        },
                    },
                    file_ignore_patterns = {},
                },
                pickers = {
                    find_files = {
                        prompt_title = 'All Files',
                    },
                    current_buffer_fuzzy_find = {
                        prompt_title = 'Current Buffer',
                    },
                    oldfiles = {
                        prompt_title = "History",
                    },
                    buffers = {
                        mappings = {
                            i = {
                                ["<C-x>"] = "delete_buffer",
                            }
                        }
                    },
                },
            }
            -- Enable telescope fzf native, if installed
            pcall(require('telescope').load_extension, 'fzf')
            require('telescope').load_extension('noice')        -- noice extension
            require('telescope').load_extension('file_browser') -- file browser
            -- require('telescope').extensions.notify.notify())

            -- Setup keymaps i guess
            vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Telescope Find Files" })
            vim.keymap.set('n', '<leader>fs', builtin.live_grep, { desc = "Telescope Find String" })
            vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Telescope Buffers" })
            vim.keymap.set('n', '<leader>fi', builtin.current_buffer_fuzzy_find, { desc = "Telescope Find in Buffer" })
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Telescope Find Help" })
            vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = "Telescope Find Git Files" })
            vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = "Telescope Find in History" })
            vim.keymap.set('n', '<leader>fc', builtin.commands, { desc = "Telescope Find Commands" })

            -- file broswer
            vim.keymap.set('n', '<leader>fd', browser.file_browser)

            -- local notify = require('telescope').load_extension('notify')
            -- vim.keymap.set('n', '<leader>fn', notify.notify())
        end,

    },
}
