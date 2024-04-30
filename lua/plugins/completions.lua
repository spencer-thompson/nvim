-- completion
local cmp = require('cmp')
local lspkind = require('lspkind')
local luasnip = require('luasnip')

local key_len = 2
local max_item = 30

cmp.setup({
    sources = {
        { name = 'nvim_lsp', keyword_length = key_len, max_item_count = max_item },
        { name = 'nvim_lua', keyword_length = key_len, max_item_count = max_item },
        { name = 'luasnip', keyword_length = key_len, max_item_count = max_item },
        { name = 'buffer', keyword_length = key_len, max_item_count = max_item },
    },
    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol',
            maxwidth = 50,
            ellipsis_char = '...',
            show_labelDetails = true,
        }),
    },
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    completion = {
        completeopt = 'menu,menuone,preview,noinsert',
    },
    mapping = cmp.mapping.preset.insert({
        -- Ctrl + space triggers completion menu
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<C-k>'] = cmp.mapping.select_prev_item(),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<Tab>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
        -- ['<C-i>'] = cmp.mapping(function(fallback)
        --     if cmp.visible() then
        --         if luasnip.expand_or_jumpable() then
        --             luasnip.expand_or_jump()
        --         end
        --     else
        --         fallback()
        --     end
        -- end),
        -- ['<CR>'] = cmp.mapping.confirm({ select = false }),
    }),
})

cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline({
        ['<C-Space>'] = cmp.mapping({
            i = cmp.mapping.complete(),
            c = cmp.mapping.complete(),
        }),
        ['<C-j>'] = cmp.mapping({
            i = cmp.mapping.select_next_item(),
            c = cmp.mapping.select_next_item(),
        }),
        ['<C-k>'] = cmp.mapping({
            i = cmp.mapping.select_prev_item(),
            c = cmp.mapping.select_prev_item(),
        }),
        ['<Tab>'] = cmp.mapping({
            i = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Replace,
                select = true,
            }),
            c = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Replace,
                select = true,
            }),
        }),
    }),
    sources = {
        { name = 'buffer', keyword_length = key_len, max_item_count = max_item },
    },
})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline({
        ['<C-Space>'] = cmp.mapping({
            i = cmp.mapping.complete(),
            c = cmp.mapping.complete(),
        }),
        ['<C-j>'] = cmp.mapping({
            i = cmp.mapping.select_next_item(),
            c = cmp.mapping.select_next_item(),
        }),
        ['<C-k>'] = cmp.mapping({
            i = cmp.mapping.select_prev_item(),
            c = cmp.mapping.select_prev_item(),
        }),
        ['<Tab>'] = cmp.mapping({
            i = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Replace,
                select = true,
            }),
            c = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Replace,
                select = true,
            }),
        }),
    }),
    sources = cmp.config.sources({
        { name = 'path', keyword_length = key_len, max_item_count = max_item },
    }, {
        { name = 'cmdline', keyword_length = key_len, max_item_count = max_item },
    }),
})
-- return {
--     {
--         "hrsh7th/nvim-cmp",
--         event = "InsertEnter",
--         dependencies = {
--             "hrsh7th/cmp-nvim-lsp",
--             "hrsh7th/cmp-buffer" ,
--             "hrsh7th/cmp-path",
--             "onsails/lspkind-nvim",
--             -- lua stuff
--             "saadparwaiz1/cmp_luasnip",
--             "L3MON4D3/LuaSnip",
--             "rafamadriz/friendly-snippets",
--             "hrsh7th/cmp-nvim-lua",
--         },
--         config = function()
--            local cmp = require 'cmp'
--            local luasnip = require 'luasnip'
--            require('luasnip.loaders.from_vscode').lazy_load()
--            luasnip.config.setup {}
--
--            cmp.setup {
--                snippet = {
--                    expand = function(args)
--                        luasnip.lsp_expand(args.body)
--                    end,
--                },
--                completion = {
--                    completeopt = 'menu,menuone,preview,noinsert',
--                },
--                mapping = cmp.mapping.preset.insert {
--                    ['<C-j>'] = cmp.mapping.select_next_item(),
--                    ['<C-k>'] = cmp.mapping.select_prev_item(),
--                    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
--                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
--                    ['<C-Space>'] = cmp.mapping.complete {},
--                    ['<C-e>'] = cmp.mapping.abort(),
--                    ['<CR>'] = cmp.mapping.confirm {
--                        behavior = cmp.ConfirmBehavior.Replace,
--                        select = true,
--                    ['<C-e>'] = cmp.mapping.abort(),
--                    },
--                    ['<Tab>'] = cmp.mapping(function(fallback)
--                        if cmp.visible() then
--                            cmp.select_next_item()
--                        elseif luasnip.expand_or_locally_jumpable() then
--                            luasnip.expand_or_jump()
--                        else
--                            fallback()
--                        end
--                    end, { 'i', 's' }),
--                    ['<S-Tab>'] = cmp.mapping(function(fallback)
--                        if cmp.visible() then
--                            cmp.select_prev_item()
--                        elseif luasnip.locally_jumpable(-1) then
--                            luasnip.jump(-1)
--                        else
--                            fallback()
--                        end
--                    end, { 'i', 's' }),
--                },
--                sources = {
--                    { name = 'nvim_lsp' }, -- possible lag source?
--                    { name = 'luasnip' },
--                    -- { name = "buffer" } -- remove possibly?
--                    { name = 'path' },
--                },
--            }
--
--        end,
--    },
--     -- { "tamago324/cmp-zsh" },
-- }
