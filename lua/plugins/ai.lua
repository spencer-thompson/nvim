return {
    { -- requires subscription
        'github/copilot.vim',
        event = 'VeryLazy',
        lazy = true,
    },
    { -- TODO: figure out
        'David-Kunz/gen.nvim',
        event = 'VeryLazy',
        lazy = true,

        config = function()
            require('gen').setup({})

            require('gen').prompts['LaTeX'] = {
                prompt =
                "Modify the following input to format it as proper LaTeX, just output the final LaTeX without additional quotes around it:\n$text",
                replace = true,
            }
        end
    }
}
