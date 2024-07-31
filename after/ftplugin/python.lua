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

local on_exit = function(obj, filename)
    -- vim.api.nvim_echo({ obj.code }, false, {})
    -- vim.api.nvim_echo({ obj.signal }, false, {})

    vim.print(obj)
    vim.api.nvim_echo({ { filename .. obj.stdout } }, false, {})
    vim.api.nvim_echo({ { filename .. obj.stderr } }, false, {})

    -- vim.api.nvim_echo({ { filename .. ' ' .. obj.stdout } }, false, {})
    -- vim.api.nvim_echo({ { filename .. ' ' .. obj.stderr } }, false, {})
end

vim.keymap.set('n', '<leader>r', function()
    local filename = vim.api.nvim_buf_get_name(0)
    local obj = vim.system({ 'python', vim.api.nvim_buf_get_name(0) }, {
        text = true,
        -- stdin = ,
    }):wait()
    on_exit(obj, filename)
end, { desc = 'Run Current File', buffer = 0 })

-- vim.api.nvim_buf_set_keymap(0, 'n', '<leader>r', '<cmd>!python %<CR>', { desc = 'Run Current File' })
