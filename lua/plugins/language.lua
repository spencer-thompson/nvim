return {

    -- Lua
    { 'folke/neodev.nvim', name = 'neodev' },
    { 'milisims/nvim-luaref', name = 'luaref', event = 'VeryLazy' }, -- lua help

    -- Markdown
    {
        'iamcco/markdown-preview.nvim', -- fancy markdown preview
        name = 'markdown-preview',
        ft = 'markdown',
        build = 'cd app && npm install',
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

    {
        'iurimateus/luasnip-latex-snippets.nvim',
        name = 'latex-snippets',
        event = 'VeryLazy',
        dependencies = {
            'lervag/vimtex',
        },
        config = function()
            require('luasnip-latex-snippets').setup({ allow_on_markdown = true })
            require('luasnip').config.setup({ enable_autosnippets = true })
        end,
    },

    -- R
    -- {
    --     'R-nvim/R.nvim',
    --     name = 'R',
    --     lazy = false,
    -- },
}
