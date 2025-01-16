return {
    { -- autoforamatting | must be setup with :Mason
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
                    svelte = { 'prettierd' },
                    javascript = { 'prettierd' },
                    -- typescript = { { "prettierd", "prettier" } },
                    -- javascriptreact = { { "prettierd", "prettier" } },
                    -- typescriptreact = { { "prettierd", "prettier" } },
                    json = { 'prettierd' },
                    jsonc = { 'prettierd' },
                    typst = { lsp_format = 'prefer' },
                    -- graphql = { { "prettierd", "prettier" } },
                    -- java = { "google-java-format" },
                    -- kotlin = { "ktlint" },
                    -- ruby = { "standardrb" },
                    -- markdown = { { 'prettierd', 'prettier' } }, -- don't like
                    -- erb = { "htmlbeautifier" },
                    html = { 'prettierd' },
                    bash = { 'beautysh' },
                    sh = { 'shfmt' },
                    zsh = { 'beautysh' },
                    -- proto = { "buf" },
                    -- rust = { "rustfmt" },
                    rust = { 'rustfmt', lsp_format = 'fallback' },
                    yaml = { 'prettierd' },
                    toml = { 'taplo' },
                    css = { 'prettierd' },
                    scss = { 'prettierd' },
                },
                format_on_save = { -- must have
                    async = false,
                    lsp_fallback = true,
                    timeout_ms = 500,
                },
            })
        end,
    },
}
