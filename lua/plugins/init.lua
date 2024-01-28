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

-- bootstrap lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
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

-- Load plugins
require('lazy').setup({

    require('plugins.actions'),
    require('plugins.ai'),
    require('plugins.cellular-automaton'),
    require('plugins.colors'),
    require('plugins.comment'),
    require('plugins.completions'),
    require('plugins.dashboard'),
    require('plugins.git'),
    require('plugins.lsp-zero'),
    require('plugins.lualine'),
    require('plugins.navigation'),
    require('plugins.misc'),
    require('plugins.telescope'),
    require('plugins.treesitter'),
    require('plugins.ui'),
    require('plugins.util'),
    require('plugins.zen'),


    defaults = {
        -- lazy = false,

        version = false,
    },
    checker = { enabled = true },
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
            },
        },
    },
    -- add opts
})

-- lazy map
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<CR>", { desc = "[L]azy" })

-- organize keymaps
local wk = require("which-key")
wk.register( -- help remembering maps
    {        -- add plugin map groups
        e = { name = "explore" },
        d = { name = "dashboard" },
        f = { name = "find" },
        s = { name = "split" },
        t = { name = "toggle" },
    },
    { prefix = "<leader>" }
)
