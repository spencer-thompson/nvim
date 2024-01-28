-- Currently my running theme is tokyonight-night
-- Just uncomment / comment to change startup theme

return {

    {
        "craftzdog/solarized-osaka.nvim",
        lazy = true,
        event = "VeryLazy",
        -- priority = 1000,
        opts = {
            transparent = true, -- enable for background
            terminal_colors = true,
        },
        config = function(_, opts)
            require("solarized-osaka").setup(opts)
            -- vim.cmd [[ set background=dark ]]
            -- vim.cmd [[ colorscheme solarized-osaka ]]
        end,
    },

    {
        "projekt0n/github-nvim-theme",
        lazy = true,
        event = "VeryLazy",
        -- priority = 1000,
        config = function()
            require("github-theme").setup()
            -- vim.cmd [[ set background=dark ]]
            -- vim.cmd [[ colorscheme github_dark_default ]] -- yessir
        end,
    },

    {
        "miikanissi/modus-themes.nvim",
        lazy = true,
        event = "VeryLazy",
        -- priority = 1000,
        opts = {},
        config = function()
            -- vim.cmd [[ set background=dark ]]
            -- vim.cmd [[ colorscheme modus ]]
        end,
    },

    {
        "rebelot/kanagawa.nvim",
        lazy = true,
        event = "VeryLazy",
        -- priority = 1000,
        opts = {},
        config = function(_, opts)
            require('kanagawa').setup({
                overrides = function(colors)
                    local theme = colors.theme
                    return {
                        TelescopeTitle = { fg = theme.ui.special, bold = true },
                        TelescopePromptNormal = { bg = theme.ui.bg_p1 },
                        TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
                        TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
                        TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
                        TelescopePreviewNormal = { bg = theme.ui.bg_dim },
                        TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
                    }
                end,
            })
            -- vim.cmd [[ set background=dark ]]
            -- vim.cmd [[ colorscheme kanagawa-wave ]]
        end,
    },

    {
        "rose-pine/neovim",
        lazy = true,
        event = "VeryLazy",
        -- priority = 1000,
        opts = {},
        config = function()
            -- vim.cmd [[ set background=dark ]]
            -- vim.cmd [[ colorscheme rose-pine ]]
        end,
    },

    {
        'folke/tokyonight.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            require('tokyonight').setup({
                style = 'night',
                -- on_highlights = function(hl, c) -- fancy telescope theme
                --     local prompt = "#2d3149"
                --     hl.TelescopeNormal = {
                --         bg = c.bg_dark,
                --         fg = c.fg_dark,
                --     }
                --     hl.TelescopeBorder = {
                --         bg = c.bg_dark,
                --         fg = c.bg_dark,
                --     }
                --     hl.TelescopePromptNormal = {
                --         bg = prompt,
                --     }
                --     hl.TelescopePromptBorder = {
                --         bg = prompt,
                --         fg = prompt,
                --     }
                --     hl.TelescopePromptTitle = {
                --         bg = prompt,
                --         fg = prompt,
                --     }
                --     hl.TelescopePreviewTitle = {
                --         bg = c.bg_dark,
                --         fg = c.bg_dark,
                --     }
                --     hl.TelescopeResultsTitle = {
                --         bg = c.bg_dark,
                --         fg = c.bg_dark,
                --     }
                -- end,
            })
            vim.cmd [[ set background=dark ]]
            vim.cmd [[ colorscheme tokyonight-night ]]
        end,
    },
}
