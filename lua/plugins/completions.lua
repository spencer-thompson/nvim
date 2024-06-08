-- completion
local cmp = require('cmp')
local lspkind = require('lspkind')
local luasnip = require('luasnip')

local key_len = 1
local max_item = 20

cmp.setup({
    sources = {
        { name = 'nvim_lsp', keyword_length = key_len, max_item_count = max_item },
        { name = 'nvim_lua', keyword_length = key_len, max_item_count = max_item },
        { name = 'luasnip', keyword_length = key_len, max_item_count = max_item },
        { name = 'buffer', keyword_length = 5, max_item_count = max_item },
        { name = 'latex_symbols', keyword_length = key_len, max_item_count = max_item },
        -- { name = 'spell', keyword_length = key_len, max_item_count = max_item },
        { name = 'emoji', keyword_length = key_len, max_item_count = max_item },
        { name = 'nerdfont', keyword_length = key_len, max_item_count = max_item },
        { name = 'path', keyword_length = key_len, max_item_count = max_item },
        -- { name = 'kitty', keyword_length = key_len, max_item_count = max_item },
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
        ['<C-i>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                if luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                end
            else
                fallback()
            end
        end),
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
        { name = 'kitty', keyword_length = key_len, max_item_count = max_item },
    }, {
        { name = 'cmdline', keyword_length = key_len, max_item_count = max_item },
    }),
})

cmp.setup.filetype({ 'sql' }, {
    sources = {
        { name = 'vim-dadbod-completions' },
        { name = 'buffer' },
    },
})
