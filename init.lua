-- Leaders
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- My Base Keymaps and options
require('sthompson')

-- Lazy plugin manager
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
    -- { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
    spec = {
        { import = 'plugins' },
    },
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

vim.keymap.set("n", "<leader>l", "<cmd>Lazy<CR>")
