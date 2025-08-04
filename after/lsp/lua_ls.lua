return {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = {
        '.luarc.json',
        '.luarc.jsonc',
        '.luacheckrc',
        '.stylua.toml',
        'stylua.toml',
        'selene.toml',
        'selene.yml',
        '.git',
    },
    settings = {
        Lua = {
            format = {
                enable = true,
                defaultConfig = {
                    indent_style = 'space',
                    indent_size = '4',
                },
            },
            runtime = {
                version = 'LuaJIT',
            },
            diagnostics = {
                globals = { 'vim' },
                disable = { 'missing-fields' },
            },
            workspace = {
                checkThirdParty = false,
                -- library = vim.api.nvim_get_runtime_file('', true),
                libary = {
                    vim.env.VIMRUNTIME,
                },
            },
            telemetry = {
                enable = false,
            },
            hint = { enable = true },
        },
    },
}
