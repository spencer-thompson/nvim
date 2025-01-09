-- local options
-- vim.opt_local.shiftwidth = 2
vim.opt_local.wrap = false
vim.bo.commentstring = '// %s'

vim.api.nvim_buf_set_var(0, 'active_preview', false)

-- require('nvim-surround').buffer_setup({
--     delimiters = {
--         ['$'] = {
--             add = { '$', '$' },
--         },
--     },
-- })

local Job = require('plenary.job')

-- local compile_doc = Job:new({
--     command = 'typst',
--     args = {
--         'watch',
--         vim.fn.expand('%:p'),
--         '--open',
--         'zathura',
--     },
--     cwd = vim.fn.expand('%:p:h'),
--     on_stdout = function(error, data)
--         if error then
--             vim.api.nvim_err_writeln(error)
--             -- else
--             --     print('STDOUT: ', data) -- Handle standard output
--         end
--     end,
--     on_stderr = function(error, data)
--         if error then
--             vim.api.nvim_err_writeln(error)
--             print(error)
--             -- else
--             --     print('Compilation Error', data) -- Handle standard error
--         end
--     end,
-- })

local show_pdf = Job:new({
    command = 'zathura',
    args = {
        vim.fn.expand('%:p:r') .. '.pdf',
    },
    cwd = vim.fn.expand('%:p:h'),
})

vim.keymap.set('n', '<leader>r', function()
    if vim.api.nvim_buf_get_var(0, 'active_preview') then
        vim.api.nvim_buf_set_var(0, 'active_preview', false)
        -- compile_doc:shutdown(compile_doc.code, compile_doc.signal)
        local pid = show_pdf.pid
        show_pdf:shutdown()
        vim.system({ 'kill', pid })
    else
        vim.api.nvim_buf_set_var(0, 'active_preview', true)
        -- compile_doc:start()
        show_pdf:start()
    end
end, { desc = 'Markdown PDF Preview' })
