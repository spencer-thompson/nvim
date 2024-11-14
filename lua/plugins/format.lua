return {
    {
        'stevearc/conform.nvim',
        name = 'conform',
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
            local conform = require('conform')

            conform.setup({
                formatters_by_ft = {
                    awk = { 'awk' },
                    lua = { 'stylua' },
                    python = { 'ruff_format', 'ruff_organize_imports' },
                    go = { 'gofumpt' },
                    -- svelte = { { "prettierd", "prettier" } },
                    javascript = { 'prettierd' },
                    -- typescript = { { "prettierd", "prettier" } },
                    -- javascriptreact = { { "prettierd", "prettier" } },
                    -- typescriptreact = { { "prettierd", "prettier" } },
                    json = { 'prettierd' },
                    jsonc = { 'prettierd' },
                    typst = { 'typstfmt' },
                    -- graphql = { { "prettierd", "prettier" } },
                    -- java = { "google-java-format" },
                    -- kotlin = { "ktlint" },
                    -- ruby = { "standardrb" },
                    -- markdown = { { 'prettierd', 'prettier' } }, -- don't like
                    -- erb = { "htmlbeautifier" },
                    -- html = { 'htmlbeautifier' },
                    html = { 'prettierd' },
                    bash = { 'beautysh' },
                    sh = { 'shfmt' },
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
}
