return {
    { -- File tree
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("nvim-tree").setup({
                view = { width = 30 },
                filters = { dotfiles = true },
            })
            vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>")

        end,
    }
}
