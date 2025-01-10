return {
    { -- telescope is a pretty dope fuzzy finder
        'nvim-telescope/telescope.nvim',
        name = 'telescope',
        tag = '0.1.8',
        -- or                              , branch = '0.1.x',
        event = 'VeryLazy',
        -- priority = 100,
        dependencies = {

            -- { 'nvim-telescope/telescope-file-browser.nvim', name = 'telescope-file-browser' },
            -- { 'nvim-telescope/telescope-hop.nvim', name = 'telescope-hop' },
            { 'nvim-telescope/telescope-ui-select.nvim', name = 'telescope-ui-select' },
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                name = 'telescope-fzf-native',
                build = 'make',
                cond = function()
                    return vim.fn.executable('make') == 1
                end,
            },
        },

        config = function()
            local actions = require('telescope.actions')
            local builtin = require('telescope.builtin')
            -- local browser = require('telescope').extensions.file_browser
            -- local notify = require('telescope').extensions.notify
            local open_with_trouble = require('trouble.sources.telescope').open
            -- local yanky = require('telescope').extensions.yank_history

            local telescope = require('telescope')

            telescope.setup({
                defaults = {
                    layout_strategy = 'flex',
                    prompt_prefix = '-> ',
                    selection_caret = '-> ',
                    entry_prefix = '   ',
                    multi_icon = '<> ',
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
                        width = 0.90,
                        height = 0.80,

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
                            -- ['<C-h>'] = browser.actions.goto_home_dir,
                            ['q'] = actions.close,
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
                            -- ['<C-x>'] = browser.actions.remove,
                            -- ['<C-r>'] = browser.actions.rename,
                            ['<c-t>'] = open_with_trouble,
                            ['<C-h>'] = 'which_key',
                            -- ['<C-m>'] = browser.actions.move,
                        },
                    },
                    file_ignore_patterns = {},
                },
                pickers = {
                    find_files = {
                        theme = 'ivy',
                        prompt_title = 'All Files',
                        find_command = { 'rg', '--files', '--hidden', '--glob', '!**/.git/*' },
                    },
                    live_grep = {
                        theme = 'ivy',
                    },
                    help_tags = {
                        theme = 'ivy',
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
                extensions = {
                    fzf = {},
                },
            })
            -- Enable telescope fzf native, if installed
            pcall(require('telescope').load_extension, 'fzf')
            require('telescope').load_extension('noice') -- noice extension
            -- require('telescope').load_extension('file_browser') -- file browser

            -- Setup keymaps i guess
            vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
            vim.keymap.set('n', '<leader>fs', builtin.live_grep, { desc = '[F]ind [S]tring' })
            vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = '[F]ind [B]uffers' })
            vim.keymap.set('n', '<leader>fi', builtin.current_buffer_fuzzy_find, { desc = '[[F]]ind [i]n Buffer' })
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp' })
            vim.keymap.set('n', '<leader>fH', builtin.highlights, { desc = '[F]ind [H]ighlights' })
            vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = '[F]ind [G]it Files' })
            vim.keymap.set('n', '<leader>f:', builtin.commands, { desc = '[F]ind Commands' })
            vim.keymap.set('n', '<leader>fr', builtin.registers, { desc = '[F]ind [R]egisters' })
            -- vim.keymap.set('n', '<leader>ft', builtin.treesitter, { desc = '[F]ind [T]reesitter' })
            vim.keymap.set('n', '<leader>fc', builtin.git_commits, { desc = '[F]ind [C]ommits' })
            vim.keymap.set('n', '<leader>fC', builtin.colorscheme, { desc = '[F]ind [C]olorschemes' })
            vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[F]ind [D]iagnostics' })
            vim.keymap.set('n', '<leader>fo', builtin.vim_options, { desc = '[F]ind [O]ptions' })

            -- vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = "Telescope Find in History" })

            -- file browser
            -- vim.keymap.set('n', '<leader>fd', browser.file_browser, { desc = 'File Browser' })

            -- notifications
            -- vim.keymap.set('n', '<leader>fn', notify.notify, { desc = 'Notifications' })

            -- yank history
            -- vim.keymap.set('n', '<leader>fy', yanky.yank_history, { desc = "Yank History" })

            -- local notify = require('telescope').load_extension('notify')
            -- vim.keymap.set('n', '<leader>fn', notify.notify())
        end,
    },
}
