return {
    {
        "numToStr/Comment.nvim",
        event = "VeryLazy",
        config = function()
            require("Comment").setup {
                -- LHS of operator-pending mapping in NORMAL + VISUAL mode
                opleader = {
                    -- line-comment keymap
                    line = "gc",
                    -- block-comment keymap
                    block = "gb",
                },

                -- Create basic (operator-pending) and extended mappings for NORMAL + VISUAL mode
                mappings = {

                    -- operator-pending mapping, Includes:
                    --  `gcc`               -> line-comment  the current line
                    --  `gcb`               -> block-comment the current line
                    --  `gc[count]{motion}` -> line-comment  the region contained in {motion}
                    --  `gb[count]{motion}` -> block-comment the region contained in {motion}
                    basic = true,

                    -- extra mapping
                    -- Includes `gco`, `gcO`, `gcA`
                    extra = true,
                },

                toggler = { -- LHS of toggle mapping in NORMAL + VISUAL mode
                    -- line-comment keymap
                    --  Makes sense to be related to your opleader.line
                    line = "gcc",

                    -- block-comment keymap
                    --  Make sense to be related to your opleader.block
                    block = "gbc",
                },

                -- Pre-hook, called before commenting the line
                --    Can be used to determine the commentstring value
                -- pre_hook = nil,

                -- Post-hook, called after commenting is done
                --    Can be used to alter any formatting / newlines / etc. after commenting
                -- post_hook = nil,

                -- Can be used to ignore certain lines when doing linewise motions.
                --    Can be string (lua regex)
                --    Or function (that returns lua regex)
                -- ignore = nil,
            }

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
