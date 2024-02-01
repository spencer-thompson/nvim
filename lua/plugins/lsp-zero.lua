-- Currently unused
return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        lazy = true,
        event = "VeryLazy",
        dependencies = {
            'folke/neodev.nvim',
        },
        config = false,
        init = function()
            -- Disable automatic setup, we are doing it manually
            vim.g.lsp_zero_extend_cmp = 0
            vim.g.lsp_zero_extend_lspconfig = 0
            require('neodev').setup()
        end,
    },
    {
        'williamboman/mason.nvim',
        lazy = false,
        event = "VeryLazy",
        config = true,
    },
    {
        'folke/neodev.nvim',
        event = "VeryLazy",
        config = function()
            require('neodev').setup()
        end,
    },

    { -- Autocompletion
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {

            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-nvim-lua' },
            { 'hrsh7th/cmp-cmdline' },

            { 'L3MON4D3/LuaSnip' },
        },
        config = function()
            -- Here is where you configure the autocompletion settings.
            local lsp_zero = require('lsp-zero')
            lsp_zero.extend_cmp()

            -- And you can configure cmp even more, if you want to.
            local cmp = require('cmp')
            local cmp_action = lsp_zero.cmp_action()

            cmp.setup({
                formatting = lsp_zero.cmp_format(),
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                completion = {
                    completeopt = 'menu,menuone,preview,noinsert',
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<C-j>'] = cmp.mapping.select_next_item(),
                    ['<C-k>'] = cmp.mapping.select_prev_item(),
                    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-d>'] = cmp.mapping.scroll_docs(4),
                    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
                    ['<C-b>'] = cmp_action.luasnip_jump_backward(),
                    ['<CR>'] = cmp.mapping.confirm {
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    },
                    -- ['<Tab>'] = cmp_action.luasnip_supertab(),
                    ['<S-Tab>'] = cmp_action.luasnip_supertab(),
                    -- ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),

                }),
                sources = {
                    -- { name = 'path' },
                    { name = 'nvim_lsp', keyword_length = 2 },
                    { name = 'nvim_lua', keyword_length = 2 },
                    { name = 'luasnip',  keyword_length = 2 },
                    { name = 'buffer',   keyword_length = 2 },
                }
            })

            cmp.setup.cmdline({ '/', '?' }, {
                mapping = cmp.mapping.preset.cmdline({
                    ['<C-Space>'] = cmp.mapping.complete({
                        i = cmp.mapping.select_next_item(),
                        c = cmp.mapping.select_next_item(),
                    }),
                    ['<C-j>'] = cmp.mapping({
                        i = cmp.mapping.select_next_item(),
                        c = cmp.mapping.select_next_item(),
                    }),
                    ['<C-k>'] = cmp.mapping.select_prev_item({
                        i = cmp.mapping.select_next_item(),
                        c = cmp.mapping.select_next_item(),
                    }),
                }),
                sources = {
                    { name = 'buffer', keyword_length = 2 }
                }
            })

            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline({
                    ['<C-Space>'] = cmp.mapping.complete({
                        i = cmp.mapping.select_next_item(),
                        c = cmp.mapping.select_next_item(),
                    }),
                    ['<C-j>'] = cmp.mapping({
                        i = cmp.mapping.select_next_item(),
                        c = cmp.mapping.select_next_item(),
                    }),
                    ['<C-k>'] = cmp.mapping.select_prev_item({
                        i = cmp.mapping.select_next_item(),
                        c = cmp.mapping.select_next_item(),
                    }),

                }),
                sources = cmp.config.sources({
                    { name = 'path', keyword_length = 2, max_item_count = 30 }
                }, {
                    { name = 'cmdline', keyword_length = 2, max_item_count = 30 }
                })
            })
        end
    },

    -- LSP
    {
        'neovim/nvim-lspconfig',
        cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'williamboman/mason-lspconfig.nvim' },
        },
        config = function()
            -- This is where all the LSP shenanigans will live
            local lsp_zero = require('lsp-zero')
            lsp_zero.extend_lspconfig()

            lsp_zero.set_sign_icons({
                error = '✘',
                warn = '▲',
                hint = '⚑',
                info = '»'
            })

            -- lsp_zero.configure('lua-language-server', {
            --     settings = {
            --         Lua = {
            --             diagnostics = {
            --                 globals = { 'vim' }
            --             }
            --         }
            --     }
            -- })

            lsp_zero.on_attach(function(client, bufnr)
                -- see :help lsp-zero-keybindings to learn the available actions
                lsp_zero.default_keymaps({ buffer = bufnr })
            end)

            lsp_zero.format_on_save({
                format_opts = {
                    async = false,
                    timeout_ms = 10000,
                },
                servers = {
                    ['lua_ls'] = { 'lua' },
                    ['gopls'] = { 'go' },
                    -- ['pyright'] = { 'python' },
                },
            })

            require('mason-lspconfig').setup({
                ensure_installed = {
                    "lua_ls",
                },
                handlers = {
                    lsp_zero.default_setup,
                    lua_ls = function()
                        -- (Optional) Configure lua language server for neovim
                        local lua_opts = lsp_zero.nvim_lua_ls()
                        require('lspconfig').lua_ls.setup(lua_opts)
                    end,
                }
            })
        end
    }
}
