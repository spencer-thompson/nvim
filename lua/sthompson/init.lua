require('sthompson.settings')
require('sthompson.remap')
require('sthompson.disable_builtin')
require('sthompson.autocmds')
require('sthompson.math')

if vim.g.neovide then
    -- vim.g.neovide_transparency = 0.4
    vim.g.neovide_cursor_vfx_mode = 'wireframe'
    -- vim.g.neovide_text_gamma = 0.0
    -- vim.g.neovide_text_contrast = 0.0
    vim.o.guifont = 'JetBrainsMono Nerd Font'
end
