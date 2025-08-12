return {
    { -- treesitter provides text objects as well as syntax highlighting
        'nvim-treesitter/nvim-treesitter',
        name = 'treesitter',
        lazy = false,
        branch = 'main',
        build = ':TSUpdate',
        -- event = 'VeryLazy',
        dependencies = {
            {
                'nvim-treesitter/nvim-treesitter-textobjects',
                name = 'treesitter-textobjects',
                branch = 'main',
                keys = {
                    {
                        '<leader>sa',
                        function()
                            require('nvim-treesitter-textobjects.swap').swap_next('@parameter.inner')
                        end,
                        desc = '[S]wap Next [A]rgument',
                    },
                    {
                        '<leader>sA',
                        function()
                            require('nvim-treesitter-textobjects.swap').swap_next('@parameter.inner')
                        end,
                        desc = '[S]wap Previous [A]rgument',
                    },
                },
                opts = {
                    move = {
                        enable = true,
                        set_jumps = true,
                    },
                    swap = {
                        enable = true,
                    },
                },
            },
            {
                'folke/ts-comments.nvim',
                name = 'ts-comments',
                -- event = 'VeryLazy',
                opts = {},
            },
        },
        config = function()
            local group = vim.api.nvim_create_augroup('custom-treesitter', { clear = true })

            require('nvim-treesitter').setup({
                ensure_installed = {
                    'core',
                    'stable',
                },

                auto_install = true,

                -- install_dir = vim.fn.stdpath('data') .. '/site',
            })

            vim.api.nvim_create_autocmd('FileType', {
                group = group,
                callback = function(args)
                    local bufnr = args.buf
                    local ft = vim.bo[bufnr].filetype

                    if not vim.tbl_contains(require('nvim-treesitter').get_installed(), ft) then
                        require('nvim-treesitter').install(ft)
                    end

                    local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
                    if not ok or not parser then
                        return
                    end

                    vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

                    pcall(vim.treesitter.start)

                    -- local ft = vim.bo[bufnr].filetype
                    -- if syntax_on[ft] then
                    --     vim.bo[bufnr].syntax = 'on'
                    -- end
                end,
            })
        end,
        keys = {
            {
                '<leader>ui',
                '<cmd>InspectTree<cr>',
                desc = 'Inspect Highlights',
            },
        },
    },

    -- {
    --     'nvim-treesitter/nvim-treesitter',
    --     name = 'treesitter',
    --     lazy = false,
    --     version = false,
    --     build = ':TSUpdate',
    --     event = 'VeryLazy',
    --     -- enabled = false,
    --     dependencies = {
    --         { 'nvim-treesitter/nvim-treesitter-textobjects', name = 'treesitter-textobjects' },
    --         -- 'nvim-treesitter/playground',
    --         {
    --             'nvim-treesitter/nvim-treesitter-context',
    --             enabled = false,
    --             opts = {
    --                 -- Avoid the sticky context from growing a lot.
    --                 max_lines = 2,
    --                 -- Match the context lines to the source code.
    --                 multiline_threshold = 1,
    --                 -- Disable it when the window is too small.
    --                 min_window_height = 20,
    --                 trim_scope = 'inner',
    --             },
    --             keys = {
    --                 {
    --                     '[c',
    --                     function()
    --                         -- Jump to previous change when in diffview.
    --                         if vim.wo.diff then
    --                             return '[c'
    --                         else
    --                             vim.schedule(function()
    --                                 require('treesitter-context').go_to_context()
    --                             end)
    --                             return '<Ignore>'
    --                         end
    --                     end,
    --                     desc = 'Jump to upper context',
    --                     expr = true,
    --                 },
    --             },
    --             config = function()
    --                 require('treesitter-context').setup({
    --                     -- Avoid the sticky context from growing a lot.
    --                     max_lines = 3,
    --                     -- Match the context lines to the source code.
    --                     multiline_threshold = 1,
    --                     -- Disable it when the window is too small.
    --                     min_window_height = 20,
    --                     mode = 'topline',
    --                 })
    --
    --                 vim.api.nvim_set_hl(0, 'TreesitterContext', { link = 'Normal' })
    --                 vim.api.nvim_set_hl(0, 'TreesitterContextBottom', { underline = true, sp = '#15161e' })
    --                 vim.api.nvim_set_hl(0, 'TreesitterContextLineNumber', { link = 'FoldColumn' })
    --                 -- vim.api.nvim_set_hl(0, 'TreesitterContextLineNumberBottom', { underline = true })
    --             end,
    --         },
    --     },
    --     config = function()
    --         local toggle_inc_selection_group =
    --             vim.api.nvim_create_augroup('mariasolos/toggle_inc_selection', { clear = true })
    --         vim.api.nvim_create_autocmd('CmdwinEnter', {
    --             desc = 'Disable incremental selection when entering the cmdline window',
    --             group = toggle_inc_selection_group,
    --             command = 'TSBufDisable incremental_selection',
    --         })
    --         vim.api.nvim_create_autocmd('CmdwinLeave', {
    --             desc = 'Enable incremental selection when leaving the cmdline window',
    --             group = toggle_inc_selection_group,
    --             command = 'TSBufEnable incremental_selection',
    --         })
    --         require('nvim-treesitter.configs').setup({
    --             ensure_installed = {
    --                 'bash',
    --                 'c', -- required
    --                 'cpp',
    --                 'css',
    --                 'dockerfile',
    --                 'go',
    --                 'html',
    --                 'javascript',
    --                 'json',
    --                 'json5',
    --                 'jsonc',
    --                 'latex',
    --                 'lua', -- required
    --                 'markdown',
    --                 'markdown_inline',
    --                 'norg',
    --                 'python',
    --                 'query', -- required
    --                 'regex',
    --                 'rust',
    --                 'scss',
    --                 'svelte',
    --                 'toml',
    --                 'tsx',
    --                 'typst',
    --                 'vim', -- required
    --                 'vimdoc', --required
    --                 'vue',
    --                 'yaml',
    --                 -- 'javascript',
    --                 -- 'rust',
    --                 -- 'tsx',
    --             },
    --             sync_install = false,
    --
    --             auto_install = true,
    --
    --             highlight = {
    --                 enable = true,
    --                 additional_vim_regex_highlighting = { 'markdown' },
    --                 -- disable = { 'c', 'rust' },
    --                 -- disable = function(lang, buf)
    --                 --     local max_filesize = 100 * 1024 -- 100 KB
    --                 --     local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
    --                 --     if ok and stats and stats.size > max_filesize then
    --                 --         return true
    --                 --     end
    --                 -- end,
    --             },
    --             indent = { enable = true },
    --             incremental_selection = {
    --                 enable = true,
    --                 keymaps = {
    --                     init_selection = '<leader>v',
    --                     node_incremental = '<cr>',
    --                     scope_incremental = false,
    --                     node_decremental = '<bs>',
    --                 },
    --             },
    --
    --             textobjects = {
    --                 select = {
    --                     enable = true,
    --                     lookahead = true,
    --                     keymaps = {
    --                         ['aa'] = '@parameter.outer',
    --                         ['ia'] = '@parameter.inner',
    --                         ['af'] = '@function.outer',
    --                         ['if'] = '@function.inner',
    --                         ['ac'] = '@class.outer',
    --                         ['ic'] = '@class.inner',
    --                     },
    --                 },
    --
    --                 move = {
    --                     enable = true,
    --                     set_jumps = true,
    --                     goto_next_start = {
    --                         [']f'] = '@function.outer',
    --                         [']c'] = '@class.outer',
    --                         [']a'] = '@parameter.inner',
    --                     },
    --                     goto_next_end = {
    --                         [']F'] = '@function.outer',
    --                         [']C'] = '@class.outer',
    --                         [']A'] = '@parameter.inner',
    --                     },
    --                     goto_previous_start = {
    --                         ['[f'] = '@function.outer',
    --                         ['[c'] = '@class.outer',
    --                         ['[a'] = '@parameter.inner',
    --                     },
    --                     goto_previous_end = {
    --                         ['[F'] = '@function.outer',
    --                         ['[C'] = '@class.outer',
    --                         ['[A'] = '@parameter.inner',
    --                     },
    --                 },
    --
    --                 swap = {
    --                     enable = true,
    --                     swap_next = {
    --                         ['<leader>sa'] = '@parameter.inner',
    --                     },
    --                     swap_previous = {
    --                         ['<leader>sA'] = '@parameter.inner',
    --                     },
    --                 },
    --             },
    --         })
    --         vim.cmd([[ TSUpdate ]])
    --     end,
    --     keys = {
    --         {
    --             '<leader>ui',
    --             '<cmd>InspectTree<cr>',
    --             desc = 'Inspect Highlights',
    --         },
    --     },
    -- },
}
