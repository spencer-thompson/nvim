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
        name = 'surround',
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
        name = 'autopairs',
        event = "InsertEnter",
        opts = {} -- this is equalent to setup({}) function
    },

    { 'tpope/vim-repeat', name = 'repeat', event = 'VeryLazy' }, -- better repeating with plugins

    {
        "numToStr/Comment.nvim",
        name = 'comment',
        event = "VeryLazy",
        config = function()
            require("Comment").setup({
                padding = true,
                sticky = true,
                ignore = nil,
                toggler = { line = 'gcc', block = 'gbc' },
                opleader = { line = 'gc', block = 'gb' },
                extra = { above = 'gcO', below = 'gco', eol = 'gcA' },
                mappings = { basic = true, extra = true },
                pre_hook = nil,
                post_hook = nil,
            })

            local comment_ft = require "Comment.ft"
            comment_ft.set("lua", { "--%s", "--[[%s]]" })
        end,
    },

    { -- make TODO + ":" a fancy colored comment.
        "folke/todo-comments.nvim",
        name = 'todo-comments',
        event = "VeryLazy",
        dependecies = { "nvim-lua/plenary.nvim", name = 'plenary' },
        opts = {
            keywords = {
                DONE = { icon = " ", color = "info" },
                TODO = { icon = "󰵚 ", color = "info" },
            },
            merge_keywords = true,
        },
        keys = {
            -- keymaps
            { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
            { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
        },
        config = true,
    },

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
    --                 python = { "black" },
    --                 -- svelte = { { "prettierd", "prettier" } },
    --                 -- javascript = { { "prettierd", "prettier" } },
    --                 -- typescript = { { "prettierd", "prettier" } },
    --                 -- javascriptreact = { { "prettierd", "prettier" } },
    --                 -- typescriptreact = { { "prettierd", "prettier" } },
    --                 -- json = { { "prettierd", "prettier" } },
    --                 -- graphql = { { "prettierd", "prettier" } },
    --                 -- java = { "google-java-format" },
    --                 -- kotlin = { "ktlint" },
    --                 -- ruby = { "standardrb" },
    --                 -- markdown = { { "prettierd", "prettier" } },
    --                 -- erb = { "htmlbeautifier" },
    --                 -- html = { "htmlbeautifier" },
    --                 -- bash = { "beautysh" },
    --                 -- proto = { "buf" },
    --                 -- rust = { "rustfmt" },
    --                 -- yaml = { "yamlfix" },
    --                 -- toml = { "taplo" },
    --                 -- css = { { "prettierd", "prettier" } },
    --                 -- scss = { { "prettierd", "prettier" } },
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
