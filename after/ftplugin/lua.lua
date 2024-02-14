local group = vim.api.nvim_create_augroup("Lua auto-commands", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
  desc = "Auto-format Python with Black on save",
  pattern = "*.lua",
  group = group,
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})
