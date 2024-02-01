-- "flashes" the yanked text
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 50 })
    end,
    group = highlight_group,
    pattern = '*',
})


