vim.opt_local.wrap = false
vim.api.nvim_buf_set_keymap(0, 'n', '<leader>r', '<cmd>!Rscript %<CR>', { desc = 'Run R File' })
