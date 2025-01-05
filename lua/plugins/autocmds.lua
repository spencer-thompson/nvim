-- run: echo "hello world"

local extended_modeline = vim.api.nvim_create_augroup('ExtendedModeline', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
    pattern = '*',
    callback = function(args)
        local first_line = vim.api.nvim_buf_get_lines(args.buf, 0, 1, false)[1]
        -- vim.print(first_line)
        if string.find(first_line, 'run:') then
            local start_index, end_index = string.find(first_line, 'run: ')
            local command = string.sub(first_line, end_index + 1)
            -- vim.print(vim.api.nvim_parse_cmd(command, {}))
            vim.keymap.set('n', '<leader>r', function()
                Snacks.terminal.toggle(command, { interactive = false })
            end, { buffer = args.buf, desc = 'Run: cmd' })
        end

        -- vim.api.nvim_buf_set_keymap(args.buf, "n", "<leader>r", )
    end,
    group = extended_modeline,
})
