vim.opt_local.wrap = false

-- vim.api.nvim_buf_set_keymap(
--     0,
--     'n',
--     '<leader>r',
--     -- vim.print(vim.api.nvim_cmd("execute '!python' expand('%')")),
--     vim.system({ 'python', vim.api.nvim_buf_get_name(0) }, { text = true }, function(obj)
--         vim.print(obj.code)
--         vim.print(obj.signal)
--         vim.print(obj.stdout)
--         vim.print(obj.stderr)
--     end),
--     -- "<cmd>execute '!python' expand('%')<CR>",
--     { desc = 'Run Current File' }
-- )

local on_exit = function(obj)
    vim.print(obj.code)
    vim.print(obj.signal)
    vim.print(obj.stdout)
    vim.print(obj.stderr)
end

vim.keymap.set('n', '<leader>r', function()
    vim.system({ 'python', vim.api.nvim_buf_get_name(0) }, { text = true }, on_exit)
end, { desc = 'Run Current File', buffer = 0 })

-- vim.api.nvim_buf_set_keymap(0, 'n', '<leader>r', '<cmd>!python %<CR>', { desc = 'Run Current File' })
