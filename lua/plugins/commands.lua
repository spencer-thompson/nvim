vim.api.nvim_create_user_command('IDE', function(args)
    -- This will be a user command to essentially turn neovim into a full
    -- fledged ide, I want to implement neogit, mini.session, dap, and
    -- other plugins to create a really cool system.

    -- vim.cmd([[Trouble diagnostics toggle focus=false]])
    -- vim.cmd([[belowright ToggleTerm]])
    -- vim.cmd([[Neotree toggle show reveal]])
    -- vim.ui.select({"full", "partial"}, {prompt="Select Development Environment Features"}, function(choice)
    -- end)
    vim.cmd([[Trouble symbols toggle focus=false win={relative=editor,position=right}]])
    -- vim.wait(100)
    vim.cmd([[Trouble diagnostics toggle focus=false win={relative=win}]])
    vim.cmd([[Neotree toggle show reveal left]])
    -- vim.cmd([[Neogit]])
    -- vim.cmd([[tabfirst]])
    -- <cmd>ToggleTerm<CR>
    if args.fargs[1] == 'toggle' then
        vim.cmd([[Trouble diagnostics toggle focus=false]])
        vim.cmd([[Neotree toggle show left]])
        vim.cmd([[Trouble symbols toggle focus=false]])
    end
end, {
    nargs = '*',
    complete = function(ArgLead, CmdLine, CursorPos)
        -- return completion candidates as a list-like table
        return { 'toggle', 'on', 'off' }
    end,
})
