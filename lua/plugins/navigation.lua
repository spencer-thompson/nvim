return {
    { -- File tree
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1

            require("nvim-tree").setup({
                view = { width = 50 },
                filters = { dotfiles = true },
            })

            vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>")

        end,
    }
}
