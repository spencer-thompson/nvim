return {
    {
        'stevearc/conform.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
            local conform = require('conform')

            conform.setup({
                formatters_by_ft = {
                    lua = { 'stylua' },
                    python = { 'black' },
                    -- svelte = { { "prettierd", "prettier" } },
                    -- javascript = { { "prettierd", "prettier" } },
                    -- typescript = { { "prettierd", "prettier" } },
                    -- javascriptreact = { { "prettierd", "prettier" } },
                    -- typescriptreact = { { "prettierd", "prettier" } },
                    json = { { 'prettierd', 'prettier' } },
                    jsonc = { { 'prettierd', 'prettier' } },
                    -- graphql = { { "prettierd", "prettier" } },
                    -- java = { "google-java-format" },
                    -- kotlin = { "ktlint" },
                    -- ruby = { "standardrb" },
                    -- markdown = { { 'prettierd', 'prettier' } }, -- don't like
                    -- erb = { "htmlbeautifier" },
                    -- html = { "htmlbeautifier" },
                    bash = { 'beautysh' },
                    -- proto = { "buf" },
                    -- rust = { "rustfmt" },
                    -- yaml = { "yamlfix" },
                    -- toml = { "taplo" },
                    css = { { 'prettierd', 'prettier' } },
                    scss = { { 'prettierd', 'prettier' } },
                },
                format_on_save = {
                    async = false,
                    lsp_fallback = true,
                    timeout_ms = 500,
                },
            })
        end,
    },
}
