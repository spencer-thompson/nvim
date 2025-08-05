return {
    {
        'dmtrKovalenko/fff.nvim',
        build = 'cargo build --release',
        lazy = true,
        -- or if you are using nixos
        -- build = "nix run .#release",
        opts = {
            -- pass here all the options
            title = 'Find Files',
            prompt = '||> ',
            width = 0.85,
            height = 0.85,
            preview = {
                width = 0.6,
            },
            keymaps = {
                select = { '<CR>', '<C-y>' },
                move_up = { '<Up>', '<C-k>' },
                move_down = { '<Down>', '<C-j>' },
            },
            hl = {
                prompt = 'Constant',
            },
        },
        keys = {
            {
                'ff', -- try it if you didn't it is a banger keybinding for a picker
                function()
                    require('fff').find_files()
                end,
                desc = 'FFFind FFFiles',
            },
        },
    },
}
