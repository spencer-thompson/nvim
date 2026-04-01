vim.pack.add({
    'https://github.com/folke/tokyonight.nvim',
})

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
