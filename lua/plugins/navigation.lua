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
        lazy = false,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        },
        init = function()
            vim.keymap.set("n", "<leader>el", "<cmd>Neotree toggle<CR>")
            vim.keymap.set("n", "<leader>ee", "<cmd>Neotree toggle current<CR>")
        end,
    },
}
