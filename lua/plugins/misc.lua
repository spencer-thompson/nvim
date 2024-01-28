return {

    { 'tpope/vim-sleuth', event = 'VeryLazy' }, -- auto adjust shift and tabs

    {
        'iamcco/markdown-preview.nvim', -- fancy markdown preview
        ft = 'markdown',
        build = function()
            vim.fn['mkdp#util#install']()
            vim.keymap.set("n", "<leader>mp", "<cmd>MakrdownPreviewToggle<CR>")
        end,
        cmd = {
            'MarkdownPreviewToggle',
            'MarkdownPreview',
            'MarkdownPreviewStop',
        },
    },
}
