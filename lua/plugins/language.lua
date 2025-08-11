return {

    { -- Lua
        'folke/lazydev.nvim',
        name = 'lazydev',
        ft = 'lua', -- only load on lua files
        cmd = 'LazyDev',
        opts = {
            library = {
                { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
                { path = 'snacks.nvim', words = { 'Snacks' } },
            },
        },
    },

    -- typst
    {
        'chomosuke/typst-preview.nvim',
        name = 'typst-preview',
        ft = 'typst',
        version = '1.*',
        opts = {}, -- lazy.nvim will implicitly calls `setup {}`
    },

    -- Markdown
    {
        'iamcco/markdown-preview.nvim', -- fancy markdown preview
        name = 'markdown-preview',
        ft = 'markdown',
        enabled = false,
        -- build = 'cd app && npm install',
        build = 'cd app && yarn install',
        init = function()
            vim.g.mkdp_filetypes = { 'markdown' }
        end,
        -- build = function()
        --     if vim.loop.os_uname().sysname == 'Windows_NT' then
        --         return 'cd app && npm install'
        --     else
        --         vim.fn['mkdp#util#install']()
        --     end
        -- end,
        -- build = function()
        --     vim.fn['mkdp#util#install']()
        -- end,
        cmd = {
            'MarkdownPreviewToggle',
            'MarkdownPreview',
            'MarkdownPreviewStop',
        },
    },

    { -- 🦀
        'mrcjkb/rustaceanvim',
        -- enabled = false,
        version = '^6', -- Recommended
        ft = { 'rust' },
        -- lazy = false, -- This plugin is already lazy
    },
    -- {
    --     'pmizio/typescript-tools.nvim',
    --     name = 'typescript-tools',
    --     event = 'VeryLazy',
    --     enabled = true,
    --     dependencies = { 'nvim-lua/plenary.nvim' },
    --     opts = {},
    --     config = function()
    --         require('typescript-tools').setup({
    --             on_attach = function(client, bufnr)
    --                 client.server_capabilities.documentFormattingProvider = false
    --                 client.server_capabilities.documentRangeFormattingProvider = false
    --             end,
    --             settings = {
    --                 jsx_close_tag = {
    --                     enable = true,
    --                     filetypes = { 'javascriptreact', 'typescriptreact' },
    --                 },
    --             },
    --         })
    --     end,
    -- },

    {
        'MeanderingProgrammer/render-markdown.nvim',
        name = 'render-markdown',
        enabled = false,
        event = 'VeryLazy',
        ft = { 'codecompanion' },
    },

    -- {
    --     'iurimateus/luasnip-latex-snippets.nvim',
    --     name = 'latex-snippets',
    --     event = 'VeryLazy',
    --     dependencies = {
    --         'lervag/vimtex',
    --     },
    --     config = function()
    --         require('luasnip-latex-snippets').setup({ allow_on_markdown = true })
    --         require('luasnip').config.setup({ enable_autosnippets = true })
    --     end,
    -- },

    -- R
    -- {
    --     'R-nvim/R.nvim',
    --     name = 'R',
    --     lazy = false,
    -- },
}
