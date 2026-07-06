local icons = require('icons')

vim.pack.add({
    'https://github.com/ibhagwan/fzf-lua',
})

require('fzf-lua').setup({
    {
        'ivy',
        'hide',
        -- 'border-fused',
    },
    -- Make stuff better combine with the editor.
    fzf_colors = {
        true,
        bg = { 'bg', 'Normal' },
        info = { 'fg', 'Conditional' },
        scrollbar = { 'fg', 'Constant' },
        pointer = { 'fg', 'Constant' },
        -- separator = { 'fg', 'Variable' },
        separator = { 'fg', 'Comment' },
        hl = { 'fg', 'Comment' },
        ['hl+'] = { 'fg', 'Constant' },
        ['bg+'] = '-1',
        prompt = { 'fg', 'Constant' },
        -- ['gutter'] = ' ',
        ['gutter'] = '-1',
        -- gutter = { 'bg', 'Normal' },
    },
    fzf_opts = {
        ['--info'] = 'inline-right',
        ['--cycle'] = true,
        ['--gutter'] = ' ',
        ['--layout'] = 'reverse',
        ['--prompt'] = '||> ',
        ['--marker'] = icons.shapes.circle.small .. ' ',
        ['--pointer'] = '|>',
        ['--highlight-line'] = false,
    },
    keymap = {
        builtin = {
            ['<tab>'] = 'toggle',
            ['<C-/>'] = 'toggle-help',
            ['<C-a>'] = 'toggle-fullscreen',
            ['<C-d>'] = 'preview-page-down',
            ['<C-u>'] = 'preview-page-up',
            ['<C-l>'] = 'toggle',
        },
        fzf = {
            true,
            ['tab'] = 'select',
            ['ctrl-q'] = 'select-all+accept',
            ['ctrl-y'] = 'toggle',
            ['alt-a'] = 'toggle-all',
            ['ctrl-i'] = 'toggle-preview',
        },
    },
    winopts = {
        height = 0.4,
        -- width = 1.0,
        -- row = 1,
        border = 'single',
        -- border = { '', '─', '', '', '', '', '', '' },
        title_pos = 'center',
        preview = {
            border = 'single',
            --     -- border = { '', '─', '', '', '', '', '', '' },
            title_pos = 'center',
            scrollbar = false,
            layout = 'horizontal',
            --     vertical = 'up:40%',
        },
        on_create = function()
            vim.keymap.set('t', '<c-j>', '<down>', { silent = true, buffer = true })
            vim.keymap.set('t', '<c-k>', '<up>', { silent = true, buffer = true })
        end,
    },
    defaults = { git_icons = false, file_icons = 'mini' },
    previewers = {
        codeaction = { toggle_behavior = 'extend' },
    },
    -- Configuration for specific commands.
    files = {
        cwd_prompt = false,
        cmd = 'rg --files',
        -- winopts = {
        --     preview = { hidden = true },
        -- },
    },
    grep = {
        header_prefix = require('icons').misc.search .. ' ',
        rg_glob_fn = function(query, opts)
            local regex, flags = query:match(string.format('^(.*)%s(.*)$', opts.glob_separator))
            -- Return the original query if there's no separator.
            return (regex or query), flags
        end,
    },
    helptags = {
        actions = {
            -- Open help pages in a vertical split.
            ['enter'] = require('fzf-lua.actions').help_vert,
        },
    },
    lsp = {
        symbols = {
            symbol_icons = require('icons').symbol_kinds,
        },
        code_actions = {
            winopts = {
                width = 70,
                height = 20,
                relative = 'cursor',
                preview = {
                    hidden = false,
                    vertical = 'down:50%',
                },
            },
        },
    },
    oldfiles = {
        include_current_session = true,
    },
})

local function project_root()
    local dir = vim.fs.root(0, { '.git' })
    local home = vim.uv.os_homedir()

    if dir and home and vim.fs.normalize(dir) == vim.fs.normalize(home) then
        return nil
    end

    return dir
end

vim.keymap.set('n', '<leader>ff', function()
    local dir = project_root()
    if dir then
        FzfLua.files({ cwd = dir })
    else
        FzfLua.files()
    end
end, { desc = '[F]ind [F]iles' })

vim.keymap.set('n', '<leader>fs', '<cmd>FzfLua live_grep<cr>', { desc = '[F]ind [S]tring' })
vim.keymap.set('n', '<leader>fh', '<cmd>FzfLua helptags<cr>', { desc = '[F]ind [H]elp' })
vim.keymap.set('n', '<leader>fH', '<cmd>FzfLua highlights<cr>', { desc = '[F]ind [H]ighlight' })
