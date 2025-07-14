return {
    { -- shows what I am doing in discord
        'vyfor/cord.nvim',
        name = 'cord',
        build = ':Cord update',
        event = 'VeryLazy',
    },
    {
        'obsidian-nvim/obsidian.nvim',
        name = 'obsidian',
        -- event = 'VeryLazy',
        version = '*',
        lazy = true,
        ft = 'markdown',
        config = function()
            require('obsidian').setup({
                -- config = {
                workspaces = {
                    {
                        name = 'personal',
                        path = '~/notes/personal',
                    },
                    -- },
                },
                legacy_commands = false,
            })
            vim.keymap.set('n', 'gf', function()
                if require('obsidian').util.cursor_on_markdown_link() then
                    return '<cmd>Obsidian follow_link<CR>'
                else
                    return 'gf'
                end
            end, { noremap = false, expr = true })
        end,
    },
}
