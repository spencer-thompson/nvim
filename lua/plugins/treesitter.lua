return {
    {
        'nvim-treesitter/nvim-treesitter',
        name = 'treesitter',
        -- version = false,
        build = ':TSUpdate',
        event = 'VeryLazy',
        dependencies = {
            { 'nvim-treesitter/nvim-treesitter-textobjects', name = 'treesitter-textobjects' },
            -- 'nvim-treesitter/playground',
            { 'JoosepAlviste/nvim-ts-context-commentstring', name = 'ts-context-commentstring' },
        },
        config = function()
            -- require('nvim-treesitter.install').compilers = { "clang" }
            require('nvim-treesitter.configs').setup({
                ensure_installed = {
                    'bash',
                    'c', -- required
                    'dockerfile',
                    'go',
                    'html',
                    'lua', -- required
                    'markdown',
                    'markdown_inline',
                    'python',
                    'query', -- required
                    'vim', -- required
                    'vimdoc', --required
                    'yaml',
                    -- 'cpp',
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
                        init_selection = '<leader>v',
                        node_incremental = ']v',
                        scope_incremental = '<c-s>',
                        node_decremental = '[v',
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
                            [']m'] = '@function.outer',
                            [']]'] = '@class.outer',
                        },

                        goto_next_end = {
                            [']M'] = '@function.outer',
                            [']['] = '@class.outer',
                        },

                        goto_previous_start = {
                            ['[m'] = '@function.outer',
                            ['[['] = '@class.outer',
                        },

                        goto_previous_end = {
                            ['[M'] = '@function.outer',
                            ['[]'] = '@class.outer',
                        },
                    },

                    swap = {
                        enable = true,
                        swap_next = {
                            ['<leader>mp'] = '@parameter.inner',
                        },
                        swap_previous = {
                            ['<leader>mp'] = '@parameter.inner',
                        },
                    },
                },
            })
            vim.cmd([[ TSUpdate ]])
        end,
        -- ---@param opts TSConfig
        -- config = function(_, opts)
        --     if type(opts.ensure_installed) == "table" then
        --         ---@type table<string, boolean>
        --         local added = {}
        --         opts.ensure_installed = vim.tbl_filter(function(lang)
        --             if added[lang] then
        --                 return false
        --             end
        --             added[lang] = true
        --             return true
        --         end, opts.ensure_installed)
        --     end
        --     require('nvim-treesitter.configs').setup(opts)
        -- end,
    },
    --     {
    --         'nvim-treesitter/nvim-treesitter-context',
    --         event = 'VeryLazy',
    --         config = function()
    --             require('treesitter-context').setup()
    --             -- vim.cmd([[hi TreesitterContextBottom]])
    --             vim.keymap.set("n", "<leader>tc", "<cmd>TSContextToggle<CR>")
    --         end,
    --     }
}
