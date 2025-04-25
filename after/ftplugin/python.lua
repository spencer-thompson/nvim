-- uv is a pretty awesome python package manager
-- it is kind of like rust's cargo for python

vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'Ensure Python Virtual Environment',
    group = vim.api.nvim_create_augroup('PythonVirtualEnv', { clear = true }),
    pattern = '*.py',
    callback = function(ev)
        local root = vim.fs.root(ev.buf, '.venv')
        if not root then
            vim.notify('No Python Virtual Environment Found')
        end
    end,
})

vim.api.nvim_buf_set_keymap(
    0,
    'n',
    '<leader>r',
    '<cmd>TermExec cmd="uv run %:t" dir="%:p:h"<CR>',
    { desc = '[R]un Current File' }
)
