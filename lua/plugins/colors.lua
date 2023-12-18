-- Want to try: modus, momiji, rose-pine
return {
    {
        "craftzdog/solarized-osaka.nvim",
        lazy = false,
        priority = 1000,
        opts = {
                transparent = false, -- enable for background
                terminal_colors = true,
            },
        config = function(_, opts)
            require("solarized-osaka").setup(opts)

            vim.cmd [[ set background=dark ]]
            vim.cmd [[ colorscheme solarized-osaka ]]

        end,
    },
    {
        "miikanissi/modus-themes.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
        config = function(_, opts)

            -- vim.cmd [[ set background=dark ]]
            -- vim.cmd [[ colorscheme modus ]]

        end,
    },
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
        config = function(_, opts)

            -- vim.cmd [[ set background=dark ]]
            -- vim.cmd [[ colorscheme kanagawa-wave ]]

        end,
    },
    {
        "rose-pine/neovim",
        lazy = false,
        priority = 1000,
        opts = {},
        config = function(_, opts)

            -- vim.cmd [[ set background=dark ]]
            -- vim.cmd [[ colorscheme rose-pine ]]

        end,
    }
}