return {

    { -- requires subscription
        'github/copilot.vim',
        event = 'VeryLazy',
        lazy = true,
    },

    { -- this only really works on linux
        'David-Kunz/gen.nvim',
        event = 'VeryLazy',
        lazy = true,
        config = function()
            require('gen').setup({})
            require('gen').prompts['LaTeX'] = {
                prompt =
                "Modify the following input to format it as LaTeX, just output the final LaTeX without additional quotes around it:\n$text",
                replace = true,
            }
        end
    },

    { -- essentially chatgpt / openai
        "robitx/gp.nvim",
        config = function()
            require("gp").setup()
            -- or setup with your own config (see Install > Configuration in Readme)
            -- require("gp").setup(config)
            -- shortcuts might be setup here (see Usage > Shortcuts in Readme)
        end,
    },
}
