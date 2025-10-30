local icons = require('icons')

return {
    {
        'ibhagwan/fzf-lua',
        -- event = 'VeryLazy',
        -- enabled = false,
        cmd = 'FzfLua',
        keys = {
            -- { '<leader>f<', '<cmd>FzfLua resume<cr>', desc = 'Resume last command' },
            {
                '<leader>fb',
                '<cmd>FzfLua lgrep_curbuf<cr>',
                desc = '[F]ind in [B]uffer',
            },
            {
                '<leader><leader>',
                function()
                    FzfLua.oldfiles()
                end,
            },
            {
                '<leader>ff',
                function()
                    local dir = vim.fs.root(0, { '.git' })
                    if dir then
                        FzfLua.files({ cwd = dir })
                    else
                        FzfLua.files()
                    end
                    -- require('fzf-lua').files({})
                end,
            },
            -- { '<leader>fd', '<cmd>FzfLua lsp_document_diagnostics<cr>', desc = 'Document diagnostics' },
            -- { '<leader>fD', '<cmd>FzfLua lsp_workspace_diagnostics<cr>', desc = 'Workspace diagnostics' },
            -- { '<leader>ff', '<cmd>FzfLua files<cr>', desc = '[F]ind [F]iles' },
            { '<leader>fs', '<cmd>FzfLua live_grep<cr>', desc = '[F]ind [S]tring' },
            { '<leader>fk', '<cmd>FzfLua keymaps<cr>', desc = '[F]ind [K]eymaps' },
            { '<leader>fh', '<cmd>FzfLua helptags<cr>', desc = '[F]ind [H]elp' },
            { '<leader>fH', '<cmd>FzfLua highlights<cr>', desc = '[F]ind [H]ighlight' },
            { '<leader>fr', '<cmd>FzfLua registers<cr>', desc = '[F]ind [R]egisters' },
            { '<leader>fm', '<cmd>FzfLua marks<cr>', desc = '[F]ind [M]arks' },
            { '<leader>fM', '<cmd>FzfLua manpages<cr>', desc = '[F]ind [M]anpages' },
            { '<leader>fo', '<cmd>FzfLua oldfiles<cr>', desc = '[F]ind [O]ld files' },
            { '<leader>fz', '<cmd>FzfLua zoxide<cr>', desc = '[F]ind [Z]oxide' },
            -- {
            --     '<leader>fr',
            --     function()
            --         -- Read from ShaDa to include files that were already deleted from the buffer list.
            --         vim.cmd('rshada!')
            --         require('fzf-lua').oldfiles()
            --     end,
            --     desc = 'Recently opened files',
            -- },
            -- { 'z=', '<cmd>FzfLua spell_suggest<cr>', desc = 'Spelling suggestions' },
        },
        opts = function()
            local actions = require('fzf-lua.actions')

            return {
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
                        ['enter'] = actions.help_vert,
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
            }
        end,
    },
}
