-- Want to try: modus, momiji, rose-pine
return {
    {
        "craftzdog/solarized-osaka.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
        config = function(_, opts)

            -- vim.cmd [[ set background=dark ]]
            -- vim.cmd [[ colorscheme solarized-osaka ]]

        end,
    },
    {
        "miikanissi/modus-themes.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
        config = function(_, opts)

            vim.cmd [[ set background=dark ]]
            vim.cmd [[ colorscheme modus ]]

        end,
    },
}
