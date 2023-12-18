return {
    
    'nvim-treesitter/nvim-treesitter',
    version = false,
    build = ':TSUpdate',
    -- event = { 'LazyFile', 'VeryLazy' },
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
    },
    cmd = {
        'TSUpdateSync',
        'TSUpdate',
        'TSInstall'
    },
    init = function()
        vim.cmd [[ TSUpdate ]]
    end,
    opts = {
        ensure_installed = {
            'bash',
            'c',
            'cpp',
            'go',
            'javascript',
            'lua',
            'python',
            'rust',
            'tsx',
            'vimdoc',
            'vim',
        },

        auto_install = false,
        
        highlight = { enable = true },
        indent = { enabl = true },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = '<c-space>',
                node_incremental = '<c-space>',
                scope_incremental = '<c-s',
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
    ---@param opts TSConfig
    config = function(_, opts)
        if type(opts.ensure_installed) == "table" then
            ---@type table<string, boolean>
            local added = {}
            opts.ensure_installed = vim.tbl_filter(function(lang)
                if added[lang] then
                    return false
                end
                added[lang] = true
                return true
            end, opts.ensure_installed)
        end
        require('nvim-treesitter.configs').setup(opts)
    end,
}