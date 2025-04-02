-- local options
vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.textwidth = 120
vim.opt_local.commentstring = '// %s'

local Job = require('plenary.job')
-- vim.api.nvim_create_autocmd({ 'BufWinEnter', 'BufWritePost' }, {
--
--     desc = 'Open Typst PDF',
--     group = vim.api.nvim_create_augroup('TypstPDF', { clear = true }),
--     pattern = '*.typ',
--     callback = function(ev)
--         -- vim.api.nvim_buf_set_var(0, 'active_preview', false)
--         -- local buf_name = vim.api.nvim_buf_get_name(ev.buf)
--         -- local job = ev.data
--         local ok, resp = pcall(vim.api.nvim_buf_get_var, 'active_preview')
--         -- if not ok then
--         --     vim.api.nvim_buf_set_var(0, 'active_preview', false)
--         -- end
--
--         if ok and not resp and ev.data then
--             -- job:shutdown()
--             -- vim.print(ev.data)
--             vim.system({ 'kill', ev.data }):wait()
--         end
--
--         -- local pdf_viewer = Job:new({
--         --     command = 'zathura',
--         --     args = {
--         --         vim.fn.expand('%:p:r') .. '.pdf',
--         --     },
--         --     cwd = vim.fn.expand('%:p:h'),
--         -- })
--         -- if vim.api.nvim_buf_get_var(0, 'active_preview') then
--         --     vim.api.nvim_buf_set_var(0, 'active_preview', false)
--         --     -- local pid = pdf_viewer:pid()
--         --     pdf_viewer:shutdown()
--         --     -- vim.system({ 'kill', pid })
--         -- else
--         --     vim.api.nvim_buf_set_var(0, 'active_preview', true)
--         --     pdf_viewer:start()
--         -- end
--     end,
-- })

-- This is the auto compilation on key press BUT, it only starts zathura
-- The real magic happens with tinymist in ../../lua/plugins/lsp.lua
-- vim.keymap.set('n', '<leader>r', function()
--     local show_pdf = Job:new({
--         command = 'zathura',
--         args = {
--             vim.fn.expand('%:p:r') .. '.pdf',
--         },
--         cwd = vim.fn.expand('%:p:h'),
--     })
--
--     if vim.api.nvim_buf_get_var(0, 'active_preview') then
--         vim.api.nvim_buf_set_var(0, 'active_preview', false)
--         local pid = show_pdf:pid()
--         show_pdf:shutdown()
--         vim.system({ 'kill', pid })
--     else
--         vim.api.nvim_buf_set_var(0, 'active_preview', true)
--         show_pdf:start()
--     end
-- end, { desc = 'Markdown PDF Preview' })
--
vim.keymap.set('n', '<leader>r', function()
    local filename = vim.api.nvim_buf_get_name(0)
    local pdfname = filename:match('(.*)%.typ') .. '.pdf'
    local show_pdf = Job:new({
        command = 'zathura',
        args = {
            pdfname,
        },
        -- cwd = vim.fn.expand('%:p:h'),
    })

    local ok, res = pcall(vim.api.nvim_buf_get_var, 'active_preview')

    if not ok or not res then
        show_pdf:start()
        --     vim.api.nvim_buf_set_var(0, 'active_preview', show_pdf)
        -- end
        -- if res then
        --     res:shutdown()
        --     vim.api.nvim_buf_set_var(0, 'active_preview', false)
        --     -- else
        --     res:start()
    end
    -- else
    --     vim.system({ 'kill', res })
    --     -- vim.api.nvim_buf_set_var(0, 'active_preview', false)
    --     -- vim.api.nvim_exec_autocmds('BufWinEnter', { group = 'TypstPDF', data = show_pdf.pid })
    -- end
end, { desc = 'Typst PDF Preview' })
