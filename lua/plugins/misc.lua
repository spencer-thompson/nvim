return {

    { 'tpope/vim-sleuth', event = 'VeryLazy' }, -- auto adjust shift and tabs

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
}
