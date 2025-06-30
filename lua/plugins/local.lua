-- This is where I put plugins that I am developing on my local machine.
-- I didn't get this one working like I wanted but eventually it will be so fun.

return {
    {
        dir = '~/plugins/multiplayer.nvim',
        enabled = true,
        name = 'multiplayer',
        event = 'VeryLazy',
        opts = {
            username = 'spencer',
        },
    },

    {
        -- dir = '~/plugins/keylogger.nvim',
        'spencer-thompson/keylogger.nvim',
        opts = {},
        enabled = false,
        name = 'keylogger',
        event = 'VeryLazy',
        dependencies = { 'kkharji/sqlite.lua' },
    },

    {
        dir = '~/rk4/keytrack.nvim',
        enabled = false,
        opts = {
            url = 'api.rk4.localhost/v1/keytrack',
        },
    },
}
