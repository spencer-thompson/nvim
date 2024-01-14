return {
    {
        "folke/zen-mode.nvim",
        event = "VeryLazy",
        config = function()
            require("zen-mode").setup {
                window = {
                    backdrop = 1,
                    height = 0.9,
                    -- width = 140,
                    options = {
                        number = true,
                        relativenumber = true,
                        signcolumn = "no",
                        list = false,
                        cursorline = false,
                    },
                },
            }

            require("twilight").setup {
                context = -1,
                treesitter = true,
            }

            vim.keymap.set("n", "<leader>z", "<cmd>ZenMode<CR>", { desc = "[Z]en Mode" })
        end,
    },

    {
        "folke/twilight.nvim",
        event = "VeryLazy",
        config = function()
            require("twilight").setup {
                context = -1,
                treesitter = true,
            }
            vim.keymap.set("n", "<leader>tw", "<cmd>Twilight<CR>", { desc = "T[w]ilight" })
        end,
    },
}
