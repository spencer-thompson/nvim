-- local options
vim.opt_local.shiftwidth = 2
vim.opt_local.wrap = true
-- vim.opt_local.ff = 'unix' -- remove?

vim.api.nvim_buf_set_var(0, 'active_preview', false)

-- require('nvim-surround').buffer_setup({
--     delimiters = {
--         ['$'] = {
--             add = { '$', '$' },
--         },
--     },
-- })

local Job = require('plenary.job')

local async_compile_doc = Job:new({
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
            print(error)
        else
            print('Compilation Error', data) -- Handle standard error
        end
    end,
})


-- local async_view_doc = Job:new({
--     command = "zathura"
-- command = "sh",
-- args = { "-c", 'pkill -HUP -f "zathura $OUTPUT_FILE" || zathura "$OUTPUT_FILE" &' },
-- })

-- auto commands
local group = vim.api.nvim_create_augroup('Markdown PDF Preview', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
    desc = 'Live update compiled PDF',
    pattern = '*.md',
    group = group,
    callback = function()
        if vim.api.nvim_buf_get_var(0, 'active_preview') then
            async_compile_doc:start()
        end
    end,
})

-- local keymaps
vim.api.nvim_buf_set_keymap(
    0,
    'n',
    '<leader>r',
    '<cmd>MarkdownPreviewToggle<CR>',
    { desc = 'Markdown Browser Preview' }
)
vim.keymap.set('n', '<leader>R', function()
    if vim.api.nvim_buf_get_var(0, 'active_preview') then
        vim.api.nvim_buf_set_var(0, 'active_preview', false)
    else
        vim.api.nvim_buf_set_var(0, 'active_preview', true)

        async_compile_doc:start()
        vim.cmd([[silent !zathura "%:r".pdf &]])
    end
end, { desc = 'Markdown PDF Preview' })
