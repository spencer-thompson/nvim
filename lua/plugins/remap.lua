return {
    {
        'folke/which-key.nvim',
        event = 'VeryLazy',
        lazy = true,
        opts = {},
        config = function(opts)
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            local wk = require("which-key")
            wk.setup(opts)
            wk.register( -- help remembering maps
                {        -- add plugin map groups
                    A = { "Swap Previous Parameter" },
                    a = { "Swap Next Parameter" },
                    d = { name = "dashboard" },
                    e = { name = "explore" },
                    f = { name = "find" },
                    l = { "<cmd>Lazy<CR>", "[L]azy" }, -- vim.keymap.set("n", "<leader>l", "<cmd>Lazy<CR>", { desc = "[L]azy" })
                    s = { name = "split" },
                    t = { name = "toggle" },
                    v = { "Treesitter Selection" },
                },
                { prefix = "<leader>" }
            )
        end,
    }
}
