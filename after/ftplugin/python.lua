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

vim.api.nvim_buf_set_keymap(
    0,
    'n',
    '<leader>r',
    '<cmd>TermExec cmd="python %:t" dir=%:p:h<CR>',
    { desc = '[R]un Current File' }
)

-- vim.api.nvim_buf_set_keymap(0, 'n', '<leader>r', '<cmd>!python %<CR>', { desc = 'Run Current File' })
