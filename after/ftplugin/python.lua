local group = vim.api.nvim_create_augroup("Python auto-commands", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
  desc = "Auto-format Python with Black on save",
  pattern = "*.py",
  group = group,
  command = "undojoin | Neoformat",
})

vim.api.nvim_buf_set_keymap(
  0,
  "n",
  "<leader>r",
  "<cmd>execute '!python' expand('%')<CR>",
  { desc = "Run Current File" }
)

vim.api.nvim_buf_set_keymap(0, "n", "<leader>r", "<cmd>!python %<CR>", { desc = "Run Current File" })
