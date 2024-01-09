return {
    {
        'nvim-treesitter/nvim-treesitter',
        -- version = false,
        build = ':TSUpdate',
        event = 'VeryLazy',
        lazy = false,
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
            'nvim-treesitter/playground',
            'JoosepAlviste/nvim-ts-context-commentstring',
        },
        -- cmd = {
        --     'TSUpdateSync',
        --     'TSUpdate',
        --     'TSInstall'
        -- },
        opts = {
            ensure_installed = {
                'bash',
                'c',
                'dockerfile',
                -- 'cpp',
                'go',
                'html',
                -- 'javascript',
                'lua',
                'markdown',
                'markdown_inline',
                'python',
                -- 'rust',
                -- 'tsx',
                'vimdoc',
                'vim',
                'yaml',
            },

            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            indent = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = '<c-space>',
                    node_incremental = '<c-space>',
                    scope_incremental = '<c-s>',
                    node_decremental = '<M-space>',
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
                        ['<leader>a'] = '@parameter.inner',
                    },
                    swap_previous = {
                        ['<leader>A'] = '@parameter.inner',
                    },
                },
            },
        },
        config = function(opts)
            -- require('nvim-treesitter.install').compilers = { "clang" }
            require('nvim-treesitter.configs').setup(opts)
            vim.cmd [[ TSUpdate ]]
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
