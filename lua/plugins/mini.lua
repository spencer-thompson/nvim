return {

    { -- This is a bunch of super helpful and basic stuff
        'echasnovski/mini.nvim',
        name = 'mini',
        version = false,
        -- event = 'VimEnter',
        config = function()
            require('mini.ai').setup({
                n_lines = 300,
                custom_textobjects = {
                    o = require('mini.ai').gen_spec.treesitter({ -- code block
                        a = { '@block.outer', '@conditional.outer', '@loop.outer' },
                        i = { '@block.inner', '@conditional.inner', '@loop.inner' },
                    }),
                    f = require('mini.ai').gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }),
                    c = require('mini.ai').gen_spec.treesitter({
                        a = { '@string.outer', '@comment.outer', '@line_comment.outer', '@block_comment.outer' },
                        i = { '@string.inner', '@comment.inner', '@line_comment.inner', '@block_comment.inner' },
                    }),
                    e = { -- Word with case
                        {
                            '%u[%l%d]+%f[^%l%d]',
                            '%f[%S][%l%d]+%f[^%l%d]',
                            '%f[%P][%l%d]+%f[^%l%d]',
                            '^[%l%d]+%f[^%l%d]',
                        },
                        '^().*()$',
                    },
                    -- P = require('mini.ai').gen_spec.treesitter({ a = '@parameter.outer', i = '@parameter.inner' }),
                    A = require('mini.ai').gen_spec.treesitter({ a = '@assignment.outer', i = '@assignment.inner' }),
                    N = require('mini.ai').gen_spec.treesitter({ a = '@number.outer', i = '@number.inner' }),
                    C = require('mini.ai').gen_spec.treesitter({ a = '@call.outer', i = '@call.inner' }),

                    -- Dollar signs for markdown and typst
                    ['$'] = { '%$%s*().-()%s*%$' },
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
            require('mini.move').setup({
                mappings = {
                    left = 'H',
                    right = 'L',
                    down = 'J',
                    up = 'K',
                },
            })
            require('mini.operators').setup({
                sort = {
                    prefix = 'gS',
                    func = nil,
                },
            })
            -- require('mini.sessions').setup({})
            require('mini.splitjoin').setup({
                mappings = {
                    toggle = 'gs',
                    -- split = 'gs',
                    -- join = 'gj',
                },
            })
            -- local gen_loader = require('mini.snippets').gen_loader
            -- require('mini.snippets').setup({
            --     mappings = {
            --         -- Expand snippet at cursor position. Created globally in Insert mode.
            --         expand = '<C-l>',
            --
            --         -- Interact with default `expand.insert` session.
            --         -- Created for the duration of active session(s)
            --         jump_next = '<C-l>',
            --         jump_prev = '<C-h>',
            --         stop = '<C-c>',
            --     },
            --     snippets = {
            --         gen_loader.from_file('~/.config/nvim/snippets/global.json'),
            --         gen_loader.from_lang(),
            --     },
            -- })
            require('mini.surround').setup({
                mappings = {
                    add = 'sa', -- Add surrounding in Normal and Visual modes
                    delete = 'sd', -- Delete surrounding
                    find = 'sf', -- Find surrounding (to the right)
                    find_left = 'sF', -- Find surrounding (to the left)
                    highlight = 'sh', -- Highlight surrounding
                    replace = 'sr', -- Replace surrounding
                    update_n_lines = 'sn', -- Update `n_lines`

                    suffix_last = 'l', -- Suffix to search with "prev" method
                    suffix_next = 'n', -- Suffix to search with "next" method
                },
                silent = true,
                n_lines = 50,
            })
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
            local pairs_opts = {
                modes = { insert = true, command = true, terminal = false },
                -- skip autopair when next character is one of these
                skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
                -- skip autopair when the cursor is inside these treesitter nodes
                skip_ts = { 'string' },
                -- skip autopair when next character is closing pair
                -- and there are more closing pairs than opening pairs
                skip_unbalanced = true,
                -- better deal with markdown code blocks
                markdown = true,
            }

            -- from lazyvim
            local pairs = require('mini.pairs')
            pairs.setup(pairs_opts)
            local open = pairs.open
            pairs.open = function(pair, neigh_pattern)
                if vim.fn.getcmdline() ~= '' then
                    return open(pair, neigh_pattern)
                end
                local o, c = pair:sub(1, 1), pair:sub(2, 2)
                local line = vim.api.nvim_get_current_line()
                local cursor = vim.api.nvim_win_get_cursor(0)
                local next = line:sub(cursor[2] + 1, cursor[2] + 1)
                local before = line:sub(1, cursor[2])
                if pairs_opts.markdown and o == '`' and vim.bo.filetype == 'markdown' and before:match('^%s*``') then
                    return '`\n```' .. vim.api.nvim_replace_termcodes('<up>', true, true, true)
                end
                if pairs_opts.skip_next and next ~= '' and next:match(pairs_opts.skip_next) then
                    return o
                end
                if pairs_opts.skip_ts and #pairs_opts.skip_ts > 0 then
                    local ok, captures =
                        pcall(vim.treesitter.get_captures_at_pos, 0, cursor[1] - 1, math.max(cursor[2] - 1, 0))
                    for _, capture in ipairs(ok and captures or {}) do
                        if vim.tbl_contains(pairs_opts.skip_ts, capture.capture) then
                            return o
                        end
                    end
                end
                if pairs_opts.skip_unbalanced and next == c and c ~= o then
                    local _, count_open = line:gsub(vim.pesc(pair:sub(1, 1)), '')
                    local _, count_close = line:gsub(vim.pesc(pair:sub(2, 2)), '')
                    if count_close > count_open then
                        return o
                    end
                end
                return open(pair, neigh_pattern)
            end
            -- from lazyvim

            -- MiniPairs.map_buf()
            local ft_group = vim.api.nvim_create_augroup('filetype_pairs', { clear = true })
            vim.api.nvim_create_autocmd('BufReadPost', {
                group = ft_group,
                desc = 'Add typst $ Pairs',
                pattern = '*.typ',
                callback = function(args)
                    MiniPairs.map_buf(
                        args.buf,
                        'i',
                        '$',
                        { action = 'closeopen', pair = '$$', neigh_pattern = '[^\\].' }
                    )
                    MiniPairs.map_buf(
                        args.buf,
                        'i',
                        "'",
                        { action = 'closeopen', pair = "''", neigh_pattern = "[^%d%a\\'].", register = { cr = false } }
                    )
                end,
            })
            vim.api.nvim_create_autocmd('BufReadPost', {
                group = ft_group,
                desc = 'Triple quotes in python',
                pattern = '*.py',
                callback = function(args)
                    MiniPairs.map_buf(
                        args.buf,
                        'i',
                        '"""',
                        { action = 'closeopen', pair = '"""', neigh_pattern = '[^\\].' }
                    )
                    MiniPairs.map_buf(
                        args.buf,
                        'i',
                        "'''",
                        { action = 'closeopen', pair = "'''", neigh_pattern = '[^\\].' }
                    )
                end,
            })

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
