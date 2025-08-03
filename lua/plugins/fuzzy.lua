return {
    {
        'dmtrKovalenko/fff.nvim',
        build = 'cargo build --release',
        -- or if you are using nixos
        -- build = "nix run .#release",
        opts = {
            -- pass here all the options
            keymaps = {
                select = { '<CR>', '<C-y>' },
                move_up = { '<Up>', '<C-k>' },
                move_down = { '<Down>', '<C-j>' },
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
