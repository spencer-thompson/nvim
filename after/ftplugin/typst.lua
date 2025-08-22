-- local options
vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.textwidth = 120
vim.opt_local.commentstring = '// %s'

-- local Job = require('plenary.job')
--
-- vim.keymap.set('n', '<leader>r', function()
--     local filename = vim.api.nvim_buf_get_name(0)
--     local pdfname = filename:match('(.*)%.typ') .. '.pdf'
--     local show_pdf = Job:new({
--         command = 'zathura',
--         args = {
--             pdfname,
--         },
--         -- cwd = vim.fn.expand('%:p:h'),
--     })
--
--     local ok, res = pcall(vim.api.nvim_buf_get_var, 'active_preview')
--
--     if not ok or not res then
--         show_pdf:start()
--         --     vim.api.nvim_buf_set_var(0, 'active_preview', show_pdf)
--         -- end
--         -- if res then
--         --     res:shutdown()
--         --     vim.api.nvim_buf_set_var(0, 'active_preview', false)
--         --     -- else
--         --     res:start()
--     end
--     -- else
--     --     vim.system({ 'kill', res })
--     --     -- vim.api.nvim_buf_set_var(0, 'active_preview', false)
--     --     -- vim.api.nvim_exec_autocmds('BufWinEnter', { group = 'TypstPDF', data = show_pdf.pid })
--     -- end
-- end, { desc = 'Typst PDF Preview' })

vim.keymap.set('n', '<leader>r', '<cmd>TypstPreviewToggle<cr>', { desc = 'Typst PDF Preview', buffer = true })

-- vim.api.nvim_create_autocmd('BufWritePost', {
--     desc = 'Compile Typst PDF',
--     pattern = '*.typ',
--     callback = function()
--         vim.system({ 'typst', 'compile', vim.api.nvim_buf_get_name(0) }, { detach = true }, function()
--             return
--         end)
--     end,
-- })
