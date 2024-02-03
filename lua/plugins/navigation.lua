return {

    {
        "nvim-neo-tree/neo-tree.nvim",
        name = 'neo-tree',
        branch = "v3.x",
        event = "VeryLazy",
        dependencies = {
            { "nvim-lua/plenary.nvim",       name = "plenary" },
            { "nvim-tree/nvim-web-devicons", }, -- not strictly required, but recommended
            { "MunifTanjim/nui.nvim",        name = "nui" },
            -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        },
        config = function()
            require("neo-tree").setup({
                close_if_last_window = true,
                default_component_configs = {
                    indent = {
                        indent_size = 4,
                    }
                }
            })
            -- vim.keymap.set("n", "<leader>el", "<cmd>Neotree toggle<CR>", { desc = "Explorer [L]eft" })
            -- vim.keymap.set("n", "<leader>ee", "<cmd>Neotree toggle current<CR>", { desc = "Explorer" })
        end,
    },

    {
        'folke/flash.nvim',
        name = 'flash',
        event = 'VeryLazy',
        vscode = true,
        opts = {},
        keys = {
            { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
            { "S",     mode = { "n", "o", "x" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
            { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
            { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
        },
    },
}
