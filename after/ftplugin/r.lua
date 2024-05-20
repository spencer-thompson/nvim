vim.opt_local.wrap = false
vim.opt_local.shiftwidth = 2
vim.b.shiftwidth = 4
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2
vim.opt_local.expandtab = true
-- vim.g.r_indent_align_args = 0
vim.api.nvim_buf_set_keymap(0, 'n', '<leader>r', '<cmd>!Rscript %<CR>', { desc = 'Run R File' })
