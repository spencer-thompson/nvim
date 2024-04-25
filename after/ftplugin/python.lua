vim.opt_local.wrap = false

vim.api.nvim_buf_set_keymap(
    0,
    'n',
    '<leader>r',
    "<cmd>execute '!python' expand('%')<CR>",
    { desc = 'Run Current File' }
)

vim.api.nvim_buf_set_keymap(0, 'n', '<leader>r', '<cmd>!python %<CR>', { desc = 'Run Current File' })
