return {
    {
        'echasnovski/mini.align',
        version = '*',
        event = "VeryLazy",
        config = function()
            require('mini.align').setup()
        end,
    },
    {
        'echasnovski/mini.splitjoin',
        version = '*',
        event = "VeryLazy",
        config = function()
            require('mini.splitjoin').setup({
                mappings = {
                    toggle = 'gS', -- default
                    split = 'gs',
                    join = 'gj',
                }
            })
        end,
    },
    {
        'kylechui/nvim-surround',
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = {} -- this is equalent to setup({}) function
    },
    -- {
    --     'echasnovski/mini.pairs',
    --     version = false,
    --     event = 'VeryLazy',
    --     config = function()
    --         require('mini.pairs').setup()
    --     end,
    -- },
    -- { NOTE: Only on linux
    --     'michaelb/sniprun',
    --     event = 'VeryLazy',
    --     lazy = true,
    -- },
    -- {
    --     "stevearc/conform.nvim",
    --     event = { "BufReadPre", "BufNewFile" },
    --     config = function()
    --         local conform = require("conform")
    --
    --         conform.setup({
    --             formatters_by_ft = {
    --                 -- lua = { "stylua" },
    --                 -- svelte = { { "prettierd", "prettier" } },
    --                 -- javascript = { { "prettierd", "prettier" } },
    --                 -- typescript = { { "prettierd", "prettier" } },
    --                 -- javascriptreact = { { "prettierd", "prettier" } },
    --                 -- typescriptreact = { { "prettierd", "prettier" } },
    --                 json = { { "prettierd", "prettier" } },
    --                 -- graphql = { { "prettierd", "prettier" } },
    --                 -- java = { "google-java-format" },
    --                 -- kotlin = { "ktlint" },
    --                 -- ruby = { "standardrb" },
    --                 markdown = { { "prettierd", "prettier" } },
    --                 -- erb = { "htmlbeautifier" },
    --                 -- html = { "htmlbeautifier" },
    --                 bash = { "beautysh" },
    --                 -- proto = { "buf" },
    --                 -- rust = { "rustfmt" },
    --                 -- yaml = { "yamlfix" },
    --                 -- toml = { "taplo" },
    --                 css = { { "prettierd", "prettier" } },
    --                 scss = { { "prettierd", "prettier" } },
    --             },
    --             format_on_save = {
    --                 timeout_ms = 500,
    --                 async = false,
    --                 lsp_fallback = true,
    --             },
    --         })
    --
    --         vim.keymap.set({ "n", "v" }, "<leader>fm", function()
    --             conform.format({
    --                 lsp_fallback = true,
    --                 async = false,
    --                 timeout_ms = 500,
    --             })
    --         end, { desc = "Format file or range (in visual mode)" })
    --     end,
    -- }
}
