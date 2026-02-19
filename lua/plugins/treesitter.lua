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
            local ts_filetypes = vim.iter(require('nvim-treesitter').get_available())
                :map(function(lang)
                    return vim.treesitter.language.get_filetypes(lang)
                end)
                :flatten()
                :totable()

            require('nvim-treesitter').setup({
                ensure_installed = {
                    'core',
                    'stable',
                },

                auto_install = true,

                -- install_dir = vim.fn.stdpath('data') .. '/site',
            })

            vim.api.nvim_create_autocmd('FileType', {
                desc = 'Setup treesitter for bufffer',
                group = group,
                pattern = ts_filetypes,
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

                    vim.treesitter.start(bufnr)

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
}
