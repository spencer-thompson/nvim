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
        -- require('plugins.cellular-automaton'),
        -- require('plugins.telescope'),
        require('plugins.ai'),
        require('plugins.code'),
        require('plugins.colors'),
        require('plugins.external'),
        require('plugins.format'),
        require('plugins.fuzzy'),
        require('plugins.fzf'),
        require('plugins.git'),
        require('plugins.language'),
        require('plugins.local'),
        require('plugins.lsp'),
        require('plugins.mini'),
        require('plugins.navigation'),
        require('plugins.remap'),
        require('plugins.snacks'),
        require('plugins.sql'),
        require('plugins.terminal'),
        require('plugins.treesitter'),
        require('plugins.ui'),
        require('plugins.util'),
    },

    {
        ui = { border = 'single' },
        dev = {
            -- directory to store local plugins
            path = '~/plugins',
            fallback = false,
        },
        defaults = { version = false },
        -- concurrency = math.floor(vim.uv.available_parallelism() / 2),
        concurrency = 4,
        checker = { -- auto check for updates
            enabled = true,
            notify = false,
        },
        change_detection = { notify = false },
    }
)

-- require('plugins.autocmds')

Snacks.toggle.line_number():map('<leader>nu')

-- change current line number highlight
vim.api.nvim_set_hl(0, 'CursorLineNr', { link = 'ModeMsg' })
