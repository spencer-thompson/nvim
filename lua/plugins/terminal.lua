return {
    {
        'akinsho/toggleterm.nvim',
        name = 'toggleterm',
        event = "VeryLazy",
        version = "*",
        config = function()
            require('toggleterm').setup({

            })
            -- vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<CR>", { desc = "[T]erminal" })
            -- vim.keymap.set("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", { desc = "[F]loating Terminal" })
        end
    }
}
