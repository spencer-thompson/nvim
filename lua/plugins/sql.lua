return {
    {
        'kristijanhusak/vim-dadbod-ui',
        enabled = false,
        name = 'dadbod-ui',
        dependencies = {
            { 'tpope/vim-dadbod', name = 'dadbod', lazy = true },
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
    {
        'kndndrj/nvim-dbee',
        name = 'dbee',
        lazy = true,
        dependencies = {
            'MunifTanjim/nui.nvim',
        },
        build = function()
            -- Install tries to automatically detect the install method.
            -- if it fails, try calling it with one of these parameters:
            --    "curl", "wget", "bitsadmin", "go"
            require('dbee').install()
        end,
        config = function()
            require('dbee').setup(--[[optional config]])
        end,
    },
}
