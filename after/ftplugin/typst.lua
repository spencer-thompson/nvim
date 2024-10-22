-- local options
-- vim.opt_local.shiftwidth = 2
vim.opt_local.wrap = true
vim.bo.commentstring = '// %s'
-- vim.bo.comments = 'comments=s1:/*,mb:*,ex:*/,://' -- this breaks stuff

vim.api.nvim_buf_set_var(0, 'active_preview', false)

-- require('nvim-surround').buffer_setup({
--     delimiters = {
--         ['$'] = {
--             add = { '$', '$' },
--         },
--     },
-- })

local Job = require('plenary.job')

local compile_doc = Job:new({
    command = 'typst',
    args = {
        'watch',
        vim.fn.expand('%:p'),
        '--open',
        'zathura',
    },
    cwd = vim.fn.expand('%:p:h'),
    on_stdout = function(error, data)
        if error then
            vim.api.nvim_err_writeln(error)
            -- else
            --     print('STDOUT: ', data) -- Handle standard output
        end
    end,
    on_stderr = function(error, data)
        if error then
            vim.api.nvim_err_writeln(error)
            print(error)
            -- else
            --     print('Compilation Error', data) -- Handle standard error
        end
    end,
})

-- auto commands
local group = vim.api.nvim_create_augroup('Markdown PDF Preview', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
    desc = 'Live update compiled PDF',
    pattern = '*.md',
    group = group,
    callback = function()
        if vim.api.nvim_buf_get_var(0, 'active_preview') then
            compile_doc:start()
        end
    end,
})

-- local keymaps
-- vim.api.nvim_buf_set_keymap(
--     0,
--     'n',
--     '<leader>R',
--     '<cmd>MarkdownPreviewToggle<CR>',
--     { desc = 'Markdown Browser Preview' }
-- )

vim.keymap.set('n', '<leader>r', function()
    if vim.api.nvim_buf_get_var(0, 'active_preview') then
        vim.api.nvim_buf_set_var(0, 'active_preview', false)
        compile_doc:shutdown(compile_doc.code, compile_doc.signal)
    else
        vim.api.nvim_buf_set_var(0, 'active_preview', true)
        compile_doc:start()
    end
end, { desc = 'Markdown PDF Preview' })
