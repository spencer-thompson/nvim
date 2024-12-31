return {

    {
        'echasnovski/mini.nvim',
        name = 'mini',
        version = false,
        -- lazy = false,
        event = 'VimEnter',
        config = function()
            require('mini.ai').setup({
                n_lines = 300,
                custom_textobjects = {
                    f = require('mini.ai').gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }, {}),
                    c = require('mini.ai').gen_spec.treesitter({ a = '@comment.outer', i = '@comment.inner' }, {}),
                    -- Whole buffer
                    g = function()
                        local from = { line = 1, col = 1 }
                        local to = {
                            line = vim.fn.line('$'),
                            col = math.max(vim.fn.getline('$'):len(), 1),
                        }
                        return { from = from, to = to }
                    end,
                },
                -- Disable error feedback.
                silent = true,
                -- Don't use the previous or next text object.
                search_method = 'cover_or_next',
                -- mappings = {
                --     -- Disable next/last variants.
                --     around_next = '',
                --     inside_next = '',
                --     around_last = '',
                --     inside_last = '',
                -- },
            })
            require('mini.align').setup({
                silent = false,
            })
            require('mini.bracketed').setup({})
            require('mini.bufremove').setup({})

            vim.keymap.set('n', '<leader>bd', function()
                require('mini.bufremove').delete(0, false)
            end, { desc = '[D]elete current buffer' })

            require('mini.comment').setup({})
            require('mini.cursorword').setup({})
            require('mini.hipatterns').setup({
                highlighters = {
                    hex_color = require('mini.hipatterns').gen_highlighter.hex_color(),
                },
            })
            require('mini.move').setup({})
            -- require('mini.operators').setup({})
            -- require('mini.sessions').setup({})
            require('mini.splitjoin').setup({
                mappings = {
                    toggle = 'gS',
                    split = 'gs',
                    -- join = 'gj',
                },
            })
            -- require('mini.surround').setup({
            --     mappings = {
            --         add = 'ys', -- Add surrounding in Normal and Visual modes
            --         delete = 'ds', -- Delete surrounding
            --         find = '', -- Find surrounding (to the right)
            --         find_left = '', -- Find surrounding (to the left)
            --         highlight = '', -- Highlight surrounding
            --         replace = 'cs', -- Replace surrounding
            --         update_n_lines = '', -- Update `n_lines` default: sn
            --
            --         suffix_last = 'l', -- Suffix to search with "prev" method
            --         suffix_next = 'n', -- Suffix to search with "next" method
            --     },
            --     silent = true,
            -- })

            vim.keymap.set({ 'n', 'x' }, 's', '<Nop>')
            -- require('mini.pairs').setup({
            --     modes = { insert = true, command = true, terminal = false },
            --     -- skip autopair when next character is one of these
            --     skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
            --     -- skip autopair when the cursor is inside these treesitter nodes
            --     skip_ts = { 'string' },
            --     -- skip autopair when next character is closing pair
            --     -- and there are more closing pairs than opening pairs
            --     skip_unbalanced = true,
            --     -- better deal with markdown code blocks
            --     markdown = true,
            -- })

            require('mini.files').setup({
                mappings = {
                    close = 'q',
                    go_in = '<CR>',
                    go_in_plus = 'l',
                    go_out = 'H',
                    go_out_plus = 'h',
                    mark_goto = "'",
                    mark_set = 'm',
                    reset = '<BS>',
                    reveal_cwd = '@',
                    show_help = 'g?',
                    synchronize = 's',
                    trim_left = '<',
                    trim_right = '>',
                },
                windows = {
                    preview = true,
                    width_focus = 30,
                    width_nofocus = 15,
                    width_preview = 50,
                },
            })

            local files_set_cwd = function(path)
                -- Works only if cursor is on the valid file system entry
                local cur_entry_path = MiniFiles.get_fs_entry().path
                local cur_directory = vim.fs.dirname(cur_entry_path)
                vim.fn.chdir(cur_directory)
            end

            vim.api.nvim_create_autocmd('User', {
                pattern = 'MiniFilesBufferCreate',
                callback = function(args)
                    vim.keymap.set('n', 'g~', files_set_cwd, { buffer = args.data.buf_id })
                end,
            })

            local map_split = function(buf_id, lhs, direction, close_on_file)
                local rhs = function()
                    -- Make new window and set it as target
                    local new_target_window
                    local cur_target_window = MiniFiles.get_explorer_state().target_window
                    if cur_target_window ~= nil then
                        vim.api.nvim_win_call(cur_target_window, function()
                            vim.cmd('belowright ' .. direction .. ' split')
                            new_target_window = vim.api.nvim_get_current_win()
                        end)

                        MiniFiles.set_target_window(new_target_window)
                        MiniFiles.go_in({ close_on_file = close_on_file })
                    end
                end

                local desc = 'Split ' .. direction
                vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
            end

            vim.keymap.set('n', '<leader>e', function(...)
                if not MiniFiles.close() then
                    MiniFiles.open(...)
                end
            end, { desc = 'File [e]xplorer' })

            vim.api.nvim_create_autocmd('User', {
                pattern = 'MiniFilesBufferCreate',
                callback = function(args)
                    local buf_id = args.data.buf_id
                    -- Tweak keys to your liking
                    map_split(buf_id, 'J', 'horizontal', true)
                    map_split(buf_id, 'L', 'vertical', true)
                end,
            })

            vim.api.nvim_create_autocmd('User', {
                pattern = 'MiniFilesWindowOpen',
                callback = function(args)
                    local win_id = args.data.win_id

                    -- Customize window-local settings
                    vim.wo[win_id].winblend = 30
                    -- local config = vim.api.nvim_win_get_config(win_id)
                    -- config.border, config.title_pos = 'double', 'right'
                    -- vim.api.nvim_win_set_config(win_id, config)
                end,
            })

            require('mini.icons').setup({
                file = {
                    ['.keep'] = { glyph = '󰊢', hl = 'MiniIconsGrey' },
                    ['devcontainer.json'] = { glyph = '', hl = 'MiniIconsAzure' },
                },
                filetype = {
                    dotenv = { glyph = '', hl = 'MiniIconsYellow' },
                },
            })
            MiniIcons.mock_nvim_web_devicons()
        end,
    },
}
