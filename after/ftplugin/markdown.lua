-- local options
vim.opt_local.shiftwidth = 2
vim.opt_local.textwidth = 80
vim.opt_local.ff = 'unix'

-- local keymaps
vim.api.nvim_buf_set_keymap(0, 'n', '<localleader>r', '<cmd>MarkdownPreview<CR>',
    { desc = 'Markdown Preview' })
