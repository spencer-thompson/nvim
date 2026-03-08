return {
    { -- treesitter provides text objects as well as syntax highlighting
        'nvim-treesitter/nvim-treesitter',
        name = 'treesitter',
        lazy = false,
        branch = 'main',
        version = false,
        build = ':TSUpdate',
        cmd = { 'TSUpdate', 'TSInstall', 'TSLog', 'TSUninstall' },
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

            vim.api.nvim_create_autocmd('Filetype', {
                group = group,
                callback = function(args)
                    local ok, parser = pcall(vim.treesitter.get_parser, args.buf)
                    if not ok or not parser then
                        return
                    end

                    pcall(vim.treesitter.start)
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
}
