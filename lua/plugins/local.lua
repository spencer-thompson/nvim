vim.api.nvim_create_user_command('Test', function()
    package.loaded.collegiate = nil
    require('collegiate').first()
end, {})

return {
    {
        dir = '~/plugins/collegiate.nvim',
    },
}
