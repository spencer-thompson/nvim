return {
    {
        'nvim-telescope/telescope.nvim',
        name = 'telescope',
        tag = '0.1.5',
        -- or                              , branch = '0.1.x',
        event = 'VeryLazy',
        -- priority = 100,
        dependencies = {

            { 'nvim-telescope/telescope-file-browser.nvim', name = 'telescope-file-browser' },
            { 'nvim-telescope/telescope-hop.nvim', name = 'telescope-hop' },
            { 'nvim-telescope/telescope-ui-select.nvim', name = 'telescope-ui-select' },
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                name = 'telescope-fzf-native',
                build = 'make',
                cond = function()
                    return vim.fn.executable('make') == 1
                end,
            },
            -- {
            --     "gbprod/yanky.nvim",
            --     name = "yanky",
            --     -- event = "VeryLazy",
            --     -- dependencies = {
            --     --     { "kkharji/sqlite.lua", name = "sqlite" }
            --     -- },
            --     -- opts = {
            --     --     ring = { storage = "sqlite" },
            --     -- },
            -- },
        },

        config = function()
            local actions = require('telescope.actions')
            local builtin = require('telescope.builtin')
            local browser = require('telescope').extensions.file_browser
            local notify = require('telescope').extensions.notify
            local open_with_trouble = require('trouble.sources.telescope').open
            -- local yanky = require('telescope').extensions.yank_history

            require('telescope').setup({
                defaults = {
                    prompt_prefix = '> ',
                    selection_caret = '> ',
                    entry_prefix = '  ',
                    multi_icon = '<>',
                    borderchars = {
                        '─',
                        '│',
                        '─',
                        '│',
                        '┌',
                        '┐',
                        '┘',
                        '└',
                        -- prompt = { "─", "│", "─", "│", '┌', '┐', "│", "│" },
                        -- results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
                        -- preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
                    },
                    sorting_strategy = 'ascending',
                    layout_config = {
                        width = 0.95,
                        height = 0.85,

                        prompt_position = 'top',
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
                            ['jk'] = actions.close,
                            ['<c-t>'] = open_with_trouble,
                        },
                        i = {
                            ['<Esc>'] = actions.close,
                            ['<C-a>'] = actions.toggle_all,
                            ['<C-u>'] = false,
                            ['<C-d>'] = false,
                            ['<C-k>'] = actions.move_selection_previous, -- move to prev result
                            ['<C-j>'] = actions.move_selection_next, -- move to next result
                            ['<C-x>'] = browser.actions.remove,
                            ['<C-r>'] = browser.actions.rename,
                            ['<c-t>'] = open_with_trouble,
                            -- ['<C-m>'] = browser.actions.move,
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
                        prompt_title = 'History',
                    },
                    buffers = {
                        mappings = {
                            i = {
                                ['<C-x>'] = 'delete_buffer',
                            },
                        },
                    },
                },
            })
            -- Enable telescope fzf native, if installed
            pcall(require('telescope').load_extension, 'fzf')
            require('telescope').load_extension('noice') -- noice extension
            require('telescope').load_extension('file_browser') -- file browser
            require('telescope').load_extension('notify') -- notifications
            -- require('telescope').load_extension('yank_history') -- yank history

            -- Setup keymaps i guess
            vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind Files' })
            vim.keymap.set('n', '<leader>fs', builtin.live_grep, { desc = 'Find [S]tring' })
            vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find [B]uffers' })
            vim.keymap.set('n', '<leader>fi', builtin.current_buffer_fuzzy_find, { desc = 'Find [i]n Buffer' })
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Find [H]elp' })
            vim.keymap.set('n', '<leader>fH', builtin.highlights, { desc = 'Find [H]ighlights' })
            vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = 'Find [G]it Files' })
            vim.keymap.set('n', '<leader>f:', builtin.commands, { desc = 'Find Commands' })
            vim.keymap.set('n', '<leader>fr', builtin.registers, { desc = 'Find [R]egisters' })
            vim.keymap.set('n', '<leader>ft', builtin.treesitter, { desc = 'Find [T]reesitter' })
            vim.keymap.set('n', '<leader>fc', builtin.git_commits, { desc = 'Find [C]ommits' })
            vim.keymap.set('n', '<leader>fC', builtin.colorscheme, { desc = 'Find [C]olorschemes' })
            vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'Find [D]iagnostics' })
            vim.keymap.set('n', '<leader>fo', builtin.vim_options, { desc = 'Find [O]ptions' })

            -- vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = "Telescope Find in History" })

            -- file browser
            -- vim.keymap.set('n', '<leader>fd', browser.file_browser, { desc = 'File Browser' })

            -- notifications
            vim.keymap.set('n', '<leader>fn', notify.notify, { desc = 'Notifications' })

            -- yank history
            -- vim.keymap.set('n', '<leader>fy', yanky.yank_history, { desc = "Yank History" })

            -- local notify = require('telescope').load_extension('notify')
            -- vim.keymap.set('n', '<leader>fn', notify.notify())
        end,
    },
}
