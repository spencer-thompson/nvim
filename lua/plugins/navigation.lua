return {
    -- { -- File tree
    --     "nvim-tree/nvim-tree.lua",
    --     version = "*",
    --     lazy = false,
    --     dependencies = {
    --         "nvim-tree/nvim-web-devicons",
    --     },
    --     config = function()
    --         vim.g.loaded_netrw = 1
    --         vim.g.loaded_netrwplugin = 1
    --
    --         require("nvim-tree").setup({
    --             view = { width = 50 },
    --             filters = { dotfiles = true },
    --         })
    --
    --         vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>")
    --
    --     end,
    -- },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        event = "VeryLazy",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        },
        config = function()
            require("neo-tree").setup({
                close_if_last_window = true
            })
            vim.keymap.set("n", "<leader>el", "<cmd>Neotree toggle<CR>")
            vim.keymap.set("n", "<leader>ee", "<cmd>Neotree toggle current<CR>")
        end,
    },
    {
        'folke/flash.nvim',
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
    }
}
