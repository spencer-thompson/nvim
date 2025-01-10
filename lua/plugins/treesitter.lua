return {
    { -- treesitter provides text objects as well as syntax highlighting
        'nvim-treesitter/nvim-treesitter',
        name = 'treesitter',
        version = false,
        build = ':TSUpdate',
        event = 'VeryLazy',
        dependencies = {
            { 'nvim-treesitter/nvim-treesitter-textobjects', name = 'treesitter-textobjects' },
            -- 'nvim-treesitter/playground',
            { 'JoosepAlviste/nvim-ts-context-commentstring', name = 'ts-context-commentstring' },
            {
                'nvim-treesitter/nvim-treesitter-context',
                enabled = false,
                opts = {
                    -- Avoid the sticky context from growing a lot.
                    max_lines = 2,
                    -- Match the context lines to the source code.
                    multiline_threshold = 1,
                    -- Disable it when the window is too small.
                    min_window_height = 20,
                    trim_scope = 'inner',
                },
                keys = {
                    {
                        '[c',
                        function()
                            -- Jump to previous change when in diffview.
                            if vim.wo.diff then
                                return '[c'
                            else
                                vim.schedule(function()
                                    require('treesitter-context').go_to_context()
                                end)
                                return '<Ignore>'
                            end
                        end,
                        desc = 'Jump to upper context',
                        expr = true,
                    },
                },
                config = function()
                    require('treesitter-context').setup({
                        -- Avoid the sticky context from growing a lot.
                        max_lines = 3,
                        -- Match the context lines to the source code.
                        multiline_threshold = 1,
                        -- Disable it when the window is too small.
                        min_window_height = 20,
                        mode = 'topline',
                    })

                    vim.api.nvim_set_hl(0, 'TreesitterContext', { link = 'Normal' })
                    vim.api.nvim_set_hl(0, 'TreesitterContextBottom', { underline = true, sp = '#15161e' })
                    vim.api.nvim_set_hl(0, 'TreesitterContextLineNumber', { link = 'FoldColumn' })
                    -- vim.api.nvim_set_hl(0, 'TreesitterContextLineNumberBottom', { underline = true })
                end,
            },
        },
        config = function()
            local toggle_inc_selection_group =
                vim.api.nvim_create_augroup('mariasolos/toggle_inc_selection', { clear = true })
            vim.api.nvim_create_autocmd('CmdwinEnter', {
                desc = 'Disable incremental selection when entering the cmdline window',
                group = toggle_inc_selection_group,
                command = 'TSBufDisable incremental_selection',
            })
            vim.api.nvim_create_autocmd('CmdwinLeave', {
                desc = 'Enable incremental selection when leaving the cmdline window',
                group = toggle_inc_selection_group,
                command = 'TSBufEnable incremental_selection',
            })
            require('nvim-treesitter.configs').setup({
                ensure_installed = {
                    'bash',
                    'c', -- required
                    'cpp',
                    'dockerfile',
                    'go',
                    'html',
                    'json',
                    'json5',
                    'jsonc',
                    'lua', -- required
                    'markdown',
                    'markdown_inline',
                    'python',
                    'query', -- required
                    'regex',
                    'toml',
                    'vim', -- required
                    'vimdoc', --required
                    'yaml',
                    -- 'javascript',
                    -- 'rust',
                    -- 'tsx',
                },
                sync_install = false,

                auto_install = true,

                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = { 'markdown' },
                    disable = function(lang, buf)
                        local max_filesize = 100 * 1024 -- 100 KB
                        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                        if ok and stats and stats.size > max_filesize then
                            return true
                        end
                    end,
                },
                indent = { enable = true },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = '<cr>',
                        node_incremental = '<cr>',
                        scope_incremental = false,
                        node_decremental = '<bs>',
                    },
                },

                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ['aa'] = '@parameter.outer',
                            ['ia'] = '@parameter.inner',
                            ['af'] = '@function.outer',
                            ['if'] = '@function.inner',
                            ['ac'] = '@class.outer',
                            ['ic'] = '@class.inner',
                        },
                    },

                    move = {
                        enable = true,
                        set_jumps = true,
                        goto_next_start = {
                            [']f'] = '@function.outer',
                            [']c'] = '@class.outer',
                            [']a'] = '@parameter.inner',
                        },
                        goto_next_end = {
                            [']F'] = '@function.outer',
                            [']C'] = '@class.outer',
                            [']A'] = '@parameter.inner',
                        },
                        goto_previous_start = {
                            ['[f'] = '@function.outer',
                            ['[c'] = '@class.outer',
                            ['[a'] = '@parameter.inner',
                        },
                        goto_previous_end = {
                            ['[F'] = '@function.outer',
                            ['[C'] = '@class.outer',
                            ['[A'] = '@parameter.inner',
                        },
                    },

                    swap = {
                        enable = true,
                        swap_next = {
                            ['<leader>sa'] = '@parameter.inner',
                        },
                        swap_previous = {
                            ['<leader>sA'] = '@parameter.inner',
                        },
                    },
                },
            })
            vim.cmd([[ TSUpdate ]])
        end,
        keys = {
            {
                '<leader>ui',
                '<cmd>InspectTree<cr>',
                desc = 'Inspect Highlights',
            },
        },
    },
}
