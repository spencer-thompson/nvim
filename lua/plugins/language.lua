return {

    -- Lua
    {
        'folke/lazydev.nvim',
        name = 'lazydev',
        ft = 'lua', -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = 'luvit-meta/library', words = { 'vim%.uv' } },
            },
        },
    },
    { 'Bilal2453/luvit-meta', lazy = true }, -- optional `vim.uv` typings

    { 'milisims/nvim-luaref', name = 'luaref', event = 'VeryLazy' }, -- lua help

    -- Markdown
    -- {
    --     'iamcco/markdown-preview.nvim', -- fancy markdown preview
    --     name = 'markdown-preview',
    --     ft = 'markdown',
    --     -- build = 'cd app && npm install',
    --     build = function()
    --         vim.fn['mkdp#util#install']()
    --     end,
    --     -- build = function()
    --     --     if vim.loop.os_uname().sysname == 'Windows_NT' then
    --     --         return 'cd app && npm install'
    --     --     else
    --     --         vim.fn['mkdp#util#install']()
    --     --     end
    --     -- end,
    --     -- build = function()
    --     --     vim.fn['mkdp#util#install']()
    --     -- end,
    --     cmd = {
    --         'MarkdownPreviewToggle',
    --         'MarkdownPreview',
    --         'MarkdownPreviewStop',
    --     },
    -- },

    {
        'mrcjkb/rustaceanvim',
        version = '^5', -- Recommended
        event = 'VeryLazy',
        -- lazy = false, -- This plugin is already lazy
    },
    {
        'pmizio/typescript-tools.nvim',
        name = 'typescript-tools',
        event = 'VeryLazy',
        dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
        opts = {},
        config = function()
            require('typescript-tools').setup({
                on_attach = function(client, bufnr)
                    client.server_capabilities.documentFormattingProvider = false
                    client.server_capabilities.documentRangeFormattingProvider = false
                end,
                settings = {
                    jsx_close_tag = {
                        enable = true,
                        filetypes = { 'javascriptreact', 'typescriptreact' },
                    },
                },
            })
        end,
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
