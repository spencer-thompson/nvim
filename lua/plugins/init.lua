--[[             _
               /~_)
           ~-/'-~
           /'      ____    ____
         /'      /'    )  '  _/'/'    /
    /~\,'   _  /'    /'   _/' /'    /'
   (,/'`\____)(___,/(___/'__,(___,/(__
                                /'
                        /     /'
                       (___,/'
]]

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim' -- bootstrap lazy
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup( -- load lazy
    { -- load plugins
        require('plugins.actions'),
        require('plugins.ai'),
        require('plugins.cellular-automaton'),
        require('plugins.code'),
        require('plugins.colors'),
        require('plugins.dashboard'),
        require('plugins.format'),
        require('plugins.git'),
        require('plugins.language'),
        require('plugins.local'),
        require('plugins.lsp'),
        require('plugins.mini'),
        require('plugins.navigation'),
        require('plugins.remap'),
        require('plugins.sql'),
        require('plugins.telescope'),
        require('plugins.terminal'),
        require('plugins.treesitter'),
        require('plugins.ui'),
        require('plugins.util'),
        require('plugins.zen'),
    },

    {
        dev = {
            -- directory to store local plugins
            path = '~/plugins',
            fallback = false,
        },
        defaults = { version = false },
        checker = { -- auto check for updates
            enabled = true,
            notify = false,
        },
        change_detection = { notify = false },
    }
)

-- require('plugins.completions')
-- require('plugins.snippets')

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
