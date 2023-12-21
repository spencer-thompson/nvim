return {
    'iamcco/markdown-preview.nvim',
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
}
