-- uv is a pretty awesome python package manager
-- it is kind of like rust's cargo for python

vim.api.nvim_buf_set_keymap(
    0,
    'n',
    '<leader>r',
    '<cmd>TermExec cmd="uv run %:t" dir=%:p:h<CR>',
    { desc = '[R]un Current File' }
)
