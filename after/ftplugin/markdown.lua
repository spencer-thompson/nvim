-- local options
vim.opt_local.shiftwidth = 2
-- vim.opt_local.textwidth = 80
vim.opt_local.wrap = true
vim.opt_local.ff = 'unix'

vim.api.nvim_buf_set_var(0, 'active_preview', false)

local Job = require('plenary.job')

local function async_compile_doc()
    -- compile current file into pdf
    -- this function takes forever bro
    Job:new({
        command = 'pandoc',
        args = {
            '-f',
            'markdown',
            '-i',
            vim.fn.expand('%'),
            '-o',
            vim.fn.expand('%:r') .. '.pdf',
        },
        cwd = vim.fn.getcwd(),
        on_stdout = function(error, data)
            if error then
                vim.api.nvim_err_writeln(error)
            else
                print('STDOUT: ', data) -- Handle standard output
            end
        end,
        on_stderr = function(error, data)
            if error then
                vim.api.nvim_err_writeln(error)
            else
                print('STDERR: ', data) -- Handle standard error
            end
        end,
    }):start()
end

-- auto commands
local group = vim.api.nvim_create_augroup('Markdown PDF Preview', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
    desc = 'Live update compiled PDF',
    pattern = '*.md',
    group = group,
    callback = function()
        if vim.api.nvim_buf_get_var(0, 'active_preview') then
            async_compile_doc()
        end
    end,
})

-- local keymaps
vim.api.nvim_buf_set_keymap(0, 'n', '<leader>r', '<cmd>MarkdownPreview<CR>', { desc = 'Markdown Preview' })
vim.keymap.set('n', '<leader>R', function()
    if vim.api.nvim_buf_get_var(0, 'active_preview') then
        vim.api.nvim_buf_set_var(0, 'active_preview', false)
    else
        vim.api.nvim_buf_set_var(0, 'active_preview', true)
        async_compile_doc()
        vim.cmd([[silent !zathura "%:r".pdf &]])
    end
end, { desc = 'Markdown PDF Preview' })
