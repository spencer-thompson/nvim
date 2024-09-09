require('sthompson.settings')
require('sthompson.remap')
require('sthompson.disable_builtin')
require('sthompson.autocmds')
require('sthompson.math')

if vim.g.neovide then
    -- Helper function for transparency formatting
    local alpha = function()
        return string.format('%x', math.floor(255 * vim.g.transparency or 0.8))
    end

    vim.g.neovide_transparency = 0.8
    vim.g.transparency = 0.8
    vim.g.neovide_background_color = '#0f1117' .. alpha()

    vim.g.neovide_cursor_vfx_mode = 'wireframe'
    -- vim.g.neovide_text_gamma = 0.0
    -- vim.g.neovide_text_contrast = 0.0
    vim.o.guifont = 'JetBrainsMono Nerd Font'
end
