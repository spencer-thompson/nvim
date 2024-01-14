return {
    {
        'akinsho/toggleterm.nvim',
        version = "*",
        config = function()
            require('toggleterm').setup({

            })
            vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<CR>", { desc = "[T]erminal" })
        end
    }
}
