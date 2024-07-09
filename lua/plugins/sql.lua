return {
    {
        'kristijanhusak/vim-dadbod-ui',
        name = "dadbod-ui",
        dependencies = {
            { 'tpope/vim-dadbod', name = "dadbod", lazy = true },
        },
        cmd = {
            'DBUI',
            'DBUIToggle',
            'DBUIAddConnection',
            'DBUIFindBuffer',
        },
        init = function()
            vim.g.db_ui_use_nerd_fonts = 1
            vim.g.db_ui_use_nvim_notify = 1
            vim.g.db_ui_winwidth = 40
        end,
    },
}
