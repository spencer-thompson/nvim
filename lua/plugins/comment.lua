return { -- moved to plugins.actions
    {
        "numToStr/Comment.nvim",
        event = "VeryLazy",
        config = function()
            require("Comment").setup({
                padding = true,
                sticky = true,
                ignore = nil,
                toggler = { line = 'gcc', block = 'gbc' },
                opleader = { line = 'gc', block = 'gb' },
                extra = { above = 'gcO', below = 'gco', eol = 'gcA' },
                mappings = { basic = true, extra = true },
                pre_hook = nil,
                post_hook = nil,
            })

            local comment_ft = require "Comment.ft"
            comment_ft.set("lua", { "--%s", "--[[%s]]" })
        end,
    },

    { -- make TODO + ":" a fancy colored comment.
        "folke/todo-comments.nvim",
        event = "VeryLazy",
        dependecies = { "nvim-lua/plenary.nvim" },
        keys = {
            -- keymaps
            { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
            { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
        },
        config = true,
    },
}
