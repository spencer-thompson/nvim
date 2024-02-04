return {

    { 'tpope/vim-sleuth', event = 'VeryLazy' }, -- auto adjust shift and tabs

    {
        'iamcco/markdown-preview.nvim', -- fancy markdown preview
        name = 'markdown-preview',
        ft = 'markdown',
        build = "cd app && npm install",
        -- build = function()
        --     vim.fn['mkdp#util#install']()
        -- end,
        cmd = {
            'MarkdownPreviewToggle',
            'MarkdownPreview',
            'MarkdownPreviewStop',
        },
    },
}
