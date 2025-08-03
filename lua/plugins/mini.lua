return {

    { -- This is a bunch of super helpful and basic stuff
        'echasnovski/mini.nvim',
        name = 'mini',
        version = false,
        event = 'VimEnter',
        -- event = 'VeryLazy',
        config = function()
            require('mini.ai').setup({
                n_lines = 300,
                custom_textobjects = {
                    o = require('mini.ai').gen_spec.treesitter({ -- code block
                        a = { '@block.outer', '@conditional.outer', '@loop.outer' },
                        i = { '@block.inner', '@conditional.inner', '@loop.inner' },
                    }),
                    -- f = require('mini.ai').gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }),
                    F = require('mini.ai').gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }),
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
            require('mini.bracketed').setup({
                buffer = { suffix = 'b', options = {} },
                comment = { suffix = 'c', options = {} },
                conflict = { suffix = 'x', options = {} },
                diagnostic = { suffix = 'd', options = {} },
                file = { suffix = 'f', options = {} },
                indent = { suffix = 'i', options = {} },
                jump = { suffix = 'j', options = {} },
                location = { suffix = 'l', options = {} },
                oldfile = { suffix = '', options = {} },
                quickfix = { suffix = 'q', options = {} },
                treesitter = { suffix = '', options = {} },
                undo = { suffix = 'u', options = {} },
                window = { suffix = '', options = {} },
                yank = { suffix = 'y', options = {} },
            })
            require('mini.bufremove').setup({})

            vim.keymap.set('n', '<leader>bd', function()
                require('mini.bufremove').delete(0, false)
            end, { desc = '[D]elete current buffer' })

            -- Add a-z/A-Z marks.
            local function mark_clues()
                local marks = {}
                vim.list_extend(marks, vim.fn.getmarklist(vim.api.nvim_get_current_buf()))
                vim.list_extend(marks, vim.fn.getmarklist())

                return vim.iter(marks)
                    :map(function(mark)
                        local key = mark.mark:sub(2, 2)

                        -- Just look at letter marks.
                        if not string.match(key, '^%a') then
                            return nil
                        end

                        -- For global marks, use the file as a description.
                        -- For local marks, use the line number and content.
                        local desc
                        if mark.file then
                            desc = vim.fn.fnamemodify(mark.file, ':p:~:.')
                        elseif mark.pos[1] and mark.pos[1] ~= 0 then
                            local line_num = mark.pos[2]
                            local lines = vim.fn.getbufline(mark.pos[1], line_num)
                            if lines and lines[1] then
                                desc = string.format('%d: %s', line_num, lines[1]:gsub('^%s*', ''))
                            end
                        end

                        if desc then
                            return { mode = 'n', keys = string.format('`%s', key), desc = desc }
                        end
                    end)
                    :totable()
            end

            -- Clues for recorded macros.
            local function macro_clues()
                local res = {}
                for _, register in ipairs(vim.split('abcdefghijklmnopqrstuvwxyz', '')) do
                    local keys = string.format('"%s', register)
                    local ok, desc = pcall(vim.fn.getreg, register)
                    if ok and desc ~= '' then
                        ---@cast desc string
                        desc = string.format('register: %s', desc:gsub('%s+', ' '))
                        table.insert(res, { mode = 'n', keys = keys, desc = desc })
                        table.insert(res, { mode = 'v', keys = keys, desc = desc })
                    end
                end

                return res
            end

            -- spell suggestions
            local function make_spellsuggest_clues(labels)
                labels = labels or '123456789abcdefghijklmnopqrstuvwxyz'
                -- labels = labels or '123456789'
                local labels_arr, n = vim.split(labels, ''), labels:len()

                return function()
                    -- if started with a count, let default work
                    local count = vim.v.count
                    if count and count > 0 then
                        return {}
                    end
                    local word = vim.fn.expand('<cword>')
                    local suggestions = vim.fn.spellsuggest(word, n)
                    -- Construct clues for each combination of `z=`+label that will emulate
                    -- the following keys: `z=` + <label> + <C-u> (clear) + <index> + <CR>
                    -- This takes advantage of:
                    -- - Built-in `z=` waits for the whole index to be confirmed with <CR>.
                    -- - Allows typing any letter before pressing <CR>.
                    -- - Allows <C-u> to remove all text to the left of cursor.
                    local res = {}
                    for i = 1, n do
                        local label, desc = labels_arr[i], suggestions[i]
                        local postkeys = '<C-u>' .. i .. '<CR>'
                        -- local postkeys = '<cmd>' .. i .. 'z=<CR>'
                        -- local postkeys = i .. '<CR>'
                        table.insert(res, { mode = 'n', keys = 'z=' .. label, desc = desc, postkeys = postkeys })
                    end
                    return res
                end
            end

            -- vim.keymap.set('n', 'z=', function()
            --     local count = vim.v.count
            --     if not count then
            --         return '<nop>'
            --     end
            --     return count .. 'z='
            -- end, { expr = true })

            require('mini.clue').setup({
                triggers = {
                    -- builtins
                    { mode = 'n', keys = 'g' },
                    { mode = 'x', keys = 'g' },
                    { mode = 'n', keys = '`' },
                    { mode = 'x', keys = '`' },
                    { mode = 'n', keys = '"' },
                    { mode = 'x', keys = '"' },
                    { mode = 'i', keys = '<C-r>' },
                    { mode = 'c', keys = '<C-r>' },
                    { mode = 'n', keys = '<C-w>' },
                    { mode = 'i', keys = '<C-x>' },
                    { mode = 'n', keys = 'z' },
                    -- Leader triggers.
                    { mode = 'n', keys = '<leader>' },
                    { mode = 'x', keys = '<leader>' },
                    -- Moving between stuff.
                    { mode = 'n', keys = '[' },
                    { mode = 'n', keys = ']' },
                },
                clues = {
                    { mode = 'n', keys = '<leader>b', desc = '+buffer' },
                    { mode = 'n', keys = '<leader>c', desc = '+code' },
                    { mode = 'n', keys = '<leader>n', desc = '+notifications' },
                    -- { mode = 'x', keys = '<leader>c', desc = '+code' },
                    -- { mode = 'n', keys = '<leader>d', desc = '+debug' },
                    { mode = 'n', keys = '<leader>g', desc = '+git' },
                    { mode = 'n', keys = '<leader>f', desc = '+find' },
                    { mode = 'n', keys = '<leader>n', desc = '+notify' },
                    { mode = 'n', keys = '<leader>s', desc = '+split/show' },
                    -- { mode = 'n', keys = '<leader>m', desc = '+minimap' },
                    -- { mode = 'n', keys = '<leader>o', desc = '+overseer' },
                    { mode = 'n', keys = '<leader>t', desc = '+toggle' },
                    { mode = 'n', keys = '<leader>x', desc = '+loclist/quickfix' },
                    { mode = 'n', keys = '[', desc = '+prev' },
                    { mode = 'n', keys = ']', desc = '+next' },
                    -- { mode = 'n', keys = 'z=', postkeys = 'z' },
                    -- Builtins.
                    require('mini.clue').gen_clues.builtin_completion(),
                    require('mini.clue').gen_clues.g(),
                    require('mini.clue').gen_clues.marks(),
                    require('mini.clue').gen_clues.registers(),
                    require('mini.clue').gen_clues.windows(),
                    require('mini.clue').gen_clues.z(),
                    -- Custom extras.
                    mark_clues,

                    macro_clues,
                    make_spellsuggest_clues(),
                },
                window = {
                    delay = 300,
                    scroll_down = '<C-d>',
                    scroll_up = '<C-u>',
                    config = function(bufnr)
                        local max_width = 0
                        for _, line in ipairs(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)) do
                            max_width = math.max(max_width, vim.fn.strchars(line))
                        end

                        -- Keep some right padding.
                        max_width = max_width + 2

                        return {
                            -- Dynamic width capped at 70.
                            width = math.min(70, max_width),
                        }
                    end,
                },
            })
            require('mini.comment').setup({})
            require('mini.cursorword').setup({})

            local bar = require('icons').lines.left.vertical
            require('mini.diff').setup({
                view = {
                    style = 'sign',
                    signs = { add = bar, change = bar, delete = bar },
                },
            })
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
                replace = {
                    prefix = 'gR',
                    reindent_lineswise = true,
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
                    add = 'ys', -- Add surrounding in Normal and Visual modes
                    delete = 'ds', -- Delete surrounding
                    find = '', -- [sf] Find surrounding (to the right)
                    find_left = '', -- [sF] Find surrounding (to the left)
                    highlight = '', -- [sh] Highlight surrounding
                    replace = 'cs', -- Replace surrounding
                    update_n_lines = '', -- [sn] Update `n_lines`

                    suffix_last = 'l', -- Suffix to search with "prev" method
                    suffix_next = 'n', -- Suffix to search with "next" method
                },
                silent = true,
                n_lines = 50,
            })
            -- Remap adding surrounding to Visual mode selection
            vim.keymap.del('x', 'ys')
            vim.keymap.set('x', 'S', [[:<C-u>lua MiniSurround.add('visual')<CR>]], { silent = true })

            -- Make special mapping for "add surrounding for line"
            vim.keymap.set('n', 'yss', 'ys_', { remap = true })

            -- vim.keymap.set({ 'n', 'x' }, 's', '<Nop>')
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
                modes = { insert = true, command = false, terminal = false },
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
            -- vim.api.nvim_create_autocmd('BufReadPost', {
            --     group = ft_group,
            --     desc = 'Triple quotes in python',
            --     pattern = '*.py',
            --     callback = function(args)
            --         MiniPairs.map_buf(
            --             args.buf,
            --             'i',
            --             '"""',
            --             { action = 'closeopen', pair = '"""', neigh_pattern = '[^\\].' }
            --         )
            --         MiniPairs.map_buf(
            --             args.buf,
            --             'i',
            --             "'''",
            --             { action = 'closeopen', pair = "'''", neigh_pattern = '[^\\].' }
            --         )
            --     end,
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
            end, { desc = '[E]xplorer Files' })

            vim.api.nvim_create_autocmd('User', {
                pattern = 'MiniFilesBufferCreate',
                callback = function(args)
                    local buf_id = args.data.buf_id
                    -- Tweak keys to your liking
                    map_split(buf_id, 'J', 'horizontal', true)
                    map_split(buf_id, 'L', 'vertical', true)

                    vim.keymap.set('n', 'g~', files_set_cwd, { buffer = args.data.buf_id })

                    -- vim.opt_local.scrolloff = 0
                    -- vim.api.nvim_set_option_value('scrolloff', 0, { buf = args.data.buf_id })
                end,
            })

            vim.api.nvim_create_autocmd('User', {
                pattern = 'MiniFilesWindowOpen',
                callback = function(args)
                    local win_id = args.data.win_id

                    -- Customize window-local settings
                    vim.wo[win_id].winblend = 30
                    vim.wo[win_id].scrolloff = 0
                    vim.wo[win_id].sidescrolloff = 0
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
