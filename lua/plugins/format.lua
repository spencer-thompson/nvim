return {
    {
        'stevearc/conform.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
            local conform = require('conform')

            conform.setup({
                formatters_by_ft = {
                    awk = { 'awk' },
                    lua = { 'stylua' },
                    python = { 'black' },
                    go = { 'gofumpt' },
                    -- svelte = { { "prettierd", "prettier" } },
                    -- javascript = { { "prettierd", "prettier" } },
                    -- typescript = { { "prettierd", "prettier" } },
                    -- javascriptreact = { { "prettierd", "prettier" } },
                    -- typescriptreact = { { "prettierd", "prettier" } },
                    json = { 'prettierd' },
                    jsonc = { 'prettierd' },
                    -- graphql = { { "prettierd", "prettier" } },
                    -- java = { "google-java-format" },
                    -- kotlin = { "ktlint" },
                    -- ruby = { "standardrb" },
                    -- markdown = { { 'prettierd', 'prettier' } }, -- don't like
                    -- erb = { "htmlbeautifier" },
                    -- html = { 'htmlbeautifier' },
                    html = { 'prettierd' },
                    bash = { 'beautysh' },
                    zsh = { 'beautysh' },
                    -- proto = { "buf" },
                    -- rust = { "rustfmt" },
                    yaml = { 'prettierd' },
                    toml = { 'taplo' },
                    css = { 'prettierd' },
                    scss = { 'prettierd' },
                },
                format_on_save = {
                    async = false,
                    lsp_fallback = true,
                    timeout_ms = 500,
                },
            })
        end,
    },

    { -- unused?
        'sbdchd/neoformat',
        name = 'neoformat',
        event = 'VeryLazy',
    },
}
