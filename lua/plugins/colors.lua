-- Currently my running theme is tokyonight-night
-- Just uncomment / comment to change startup theme
-- These are just a bunch of colorschemes

return {

    {
        'tiagovla/tokyodark.nvim',
        name = 'tokyodark',
        enabled = false,
        -- priority = 1000,
        config = function()
            local p = require('tokyodark.palette')
            require('tokyodark').setup({
                transparent_background = true,
                styles = {
                    comments = { italic = true }, -- style for comments
                    keywords = { bold = true }, -- style for keywords
                    identifiers = { italic = true }, -- style for identifiers
                    functions = { bold = true }, -- style for functions
                    variables = {}, -- style for variables
                },
                custom_highlights = {
                    SpellBad = { sp = p.red, undercurl = true }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
                    SpellCap = { sp = p.orange, undercurl = true }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
                    SpellLocal = { sp = p.yellow, undercurl = true }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
                    SpellRare = { sp = p.blue, undercurl = true }, -- Word that is recognized by the spell
                },
            })
            vim.cmd.colorscheme('tokyodark')
        end,
    },

    {
        'datsfilipe/vesper.nvim',
        name = 'vesper',
        enabled = false,
        opts = {
            transparent = true,
            italics = {
                keywords = false,
                functions = false,
                variables = false,
            },
        },
    },

    {
        'craftzdog/solarized-osaka.nvim',
        name = 'solarized-osaka',
        lazy = true,
        enabled = false,
        event = 'VeryLazy',
        -- priority = 1000,
        opts = {
            transparent = false, -- enable for background
            terminal_colors = true,
        },
        config = function(_, opts)
            require('solarized-osaka').setup(opts)
            -- vim.cmd [[ set background=dark ]]
            -- vim.cmd [[ colorscheme solarized-osaka ]]
        end,
    },

    {
        'projekt0n/github-nvim-theme',
        name = 'github-theme',
        lazy = true,
        enabled = false,
        event = 'VeryLazy',
        -- priority = 1000,
        config = function()
            require('github-theme').setup()
            -- vim.cmd [[ set background=dark ]]
            -- vim.cmd [[ colorscheme github_dark_default ]] -- yessir
        end,
    },

    {
        'miikanissi/modus-themes.nvim',
        name = 'modus-themes',
        lazy = true,
        enabled = false,
        event = 'VeryLazy',
        -- priority = 1000,
        opts = {},
        config = function()
            -- vim.cmd [[ set background=dark ]]
            -- vim.cmd [[ colorscheme modus ]]
        end,
    },

    {
        'rebelot/kanagawa.nvim',
        name = 'kanagawa',
        lazy = true,
        enabled = false,
        event = 'VeryLazy',
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
        'rose-pine/neovim',
        name = 'rose-pine',
        lazy = true,
        enabled = false,
        event = 'VeryLazy',
        -- priority = 1000,
        opts = {},
        config = function()
            -- vim.cmd [[ set background=dark ]]
            -- vim.cmd [[ colorscheme rose-pine ]]
        end,
    },

    {
        'EdenEast/nightfox.nvim',
        name = 'nightfox',
        enabled = false,
        priority = 1000,
        lazy = false,
        -- event = 'VeryLazy',
        config = function()
            require('nightfox').setup({
                options = {
                    transparent = true,
                },
            })
            vim.cmd.colorscheme('carbonfox')
        end,
    },

    {
        'dgox16/oldworld.nvim', -- i like, but need transparent bg
        name = 'oldworld',
        enabled = false,
        lazy = true,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme('oldworld')
        end,
    },

    {
        'ficcdaf/ashen.nvim',
        name = 'ashen',
        -- tag = '*',
        enabled = false,
        lazy = false,
        priority = 1000,
        config = function()
            require('ashen').setup({
                transparent = true,
                style_presets = {
                    bold_functions = true,
                    italic_comments = true,
                },
            })
            -- vim.cmd.colorscheme('ashen')
        end,
    },

    {
        'folke/tokyonight.nvim',
        name = 'tokyonight',
        enabled = true,
        lazy = false,
        priority = 1000,
        config = function()
            require('tokyonight').setup({
                style = 'night',
                -- plugins = {
                --     auto = true,
                -- },
                transparent = true,
                styles = {
                    keywords = { bold = true },
                    functions = { bold = true },
                    sidebars = 'transparent', -- style for sidebars, see below
                    floats = 'transparent', -- style for floating windows
                },
                terminal_colors = true,
                -- styles = {
                --     comments = { italic = false },
                --     keywords = { italic = false },
                -- },
                on_colors = function(c)
                    c.bg_statusline = c.none
                end,
                on_highlights = function(hl, c) -- change telescope border color
                    -- hl.TelescopeBorder = {
                    --     fg = c.orange,
                    -- }
                    -- hl.BufferLineFill = {
                    --     bg = c.none,
                    -- }
                    hl.TabLineFill = {
                        bg = c.none,
                    }
                end,
            })
            vim.cmd([[ set background=dark ]])
            vim.cmd([[ colorscheme tokyonight-night ]])
        end,
    },
}
