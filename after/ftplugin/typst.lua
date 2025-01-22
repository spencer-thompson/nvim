-- local options
vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.textwidth = 120

vim.api.nvim_buf_set_var(0, 'active_preview', false)

local Job = require('plenary.job')

local show_pdf = Job:new({
    command = 'zathura',
    args = {
        vim.fn.expand('%:p:r') .. '.pdf',
    },
    cwd = vim.fn.expand('%:p:h'),
})

-- This is the auto compilation on key press BUT, it only starts zathura
-- The real magic happens with tinymist in ../../lua/plugins/lsp.lua
vim.keymap.set('n', '<leader>r', function()
    if vim.api.nvim_buf_get_var(0, 'active_preview') then
        vim.api.nvim_buf_set_var(0, 'active_preview', false)
        local pid = show_pdf.pid
        show_pdf:shutdown()
        vim.system({ 'kill', pid })
    else
        vim.api.nvim_buf_set_var(0, 'active_preview', true)
        show_pdf:start()
    end
end, { desc = 'Markdown PDF Preview' })
