--               _
--             /~_)
--         ~-/'-~
--         /'      ____    ____
--       /'      /'    )  '  _/'/'    /
--  /~\,'   _  /'    /'   _/' /'    /'
-- (,/'`\____)(___,/(___/'__,(___,/(__
--                              /'
--                      /     /'
--                     (___,/'

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim" -- bootstrap lazy
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup( -- load lazy
    {                  -- load plugins
        require('plugins.actions'),
        require('plugins.ai'),
        require('plugins.cellular-automaton'),
        require('plugins.code'),
        require('plugins.colors'),
        -- require('plugins.comment'),
        require('plugins.dashboard'),
        require('plugins.git'),
        -- require('plugins.lsp-zero'),
        require('plugins.lualine'),
        require('plugins.misc'),
        require('plugins.navigation'),
        require('plugins.telescope'),
        require('plugins.terminal'),
        require('plugins.treesitter'),
        require('plugins.ui'),
        require('plugins.util'),
        require('plugins.zen'),
    },

    {
        defaults = { version = false, },
        checker = { enabled = true }, -- auto check for updates
    }
)

require('plugins.lsp')
require('plugins.completions')
