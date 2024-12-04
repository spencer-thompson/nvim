vim.api.nvim_buf_set_keymap(
    0,
    'n',
    '<leader>r',
    '<cmd>TermExec cmd="cargo run %:t" dir=%:p:h<CR>',
    { desc = '[R]un Current File' }
)
