-- vim.api.nvim_create_user_command('Test', function()
--     package.loaded.collegiate = nil
--     require('collegiate').first()
-- end, {})
--
-- some new text

return {
    -- {
    --     dir = '~/plugins/collegiate.nvim',
    -- },
    {
        dir = '~/plugins/multiplayer.nvim',
        opts = {},
        name = 'multiplayer',
        event = 'VeryLazy',
    },
}
