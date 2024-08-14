-- "flashes" the yanked text
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 100 })
    end,
    group = highlight_group,
    pattern = '*',
})

local terminal_spell = vim.api.nvim_create_augroup('TermSpellCheck', { clear = true })
vim.api.nvim_create_autocmd('TermOpen', {
    callback = function()
        vim.opt_local.spell = false
    end,
    group = terminal_spell,
})
