return {

    { -- requires subscription
        'github/copilot.vim',
        name = 'copilot',
        event = 'BufEnter',
        lazy = true,
        config = function()
            vim.keymap.set('i', '<S-Tab>', 'copilot#Accept("\\<CR>")', {
                expr = true,
                replace_keycodes = false,
                desc = 'Copilot Suggestion',
            })
            vim.g.copilot_filetypes = { markdown = true } -- HACK: for copilot in markdown
            vim.g.copilot_no_tab_map = true
            vim.cmd([[Copilot disable]]) -- disabled by default
        end,
    },

    { -- this only really works on linux
        'David-Kunz/gen.nvim',
        name = 'gen',
        event = 'VeryLazy',
        lazy = true,
        config = function()
            require('gen').setup({})
            require('gen').prompts['LaTeX'] = {
                prompt = 'Modify the following input to format it as LaTeX, just output the final LaTeX without additional quotes around it:\n$text',
                replace = true,
            }
        end,
    },

    {
        'jackMort/ChatGPT.nvim',
        name = 'chatgpt',
        lazy = true,
        cmd = { 'ChatGPT', 'ChatGPTRun', 'ChatGPTEditWithInstruction' },
        config = function()
            require('chatgpt').setup({
                popup_layout = {
                    center = {
                        width = '85%',
                        height = '85%',
                    },
                },
                openai_params = {
                    model = 'gpt-4-turbo-preview',
                    max_tokens = 500,
                },
                openai_edit_params = {
                    model = 'gpt-4-turbo-preview',
                },
            })
        end,
    },

    -- { -- essentially chatgpt / openai
    --     "robitx/gp.nvim",
    --     event = "VeryLazy",
    --     config = function()
    --         require("gp").setup()
    --         -- or setup with your own config (see Install > Configuration in Readme)
    --         -- require("gp").setup(config)
    --         -- shortcuts might be setup here (see Usage > Shortcuts in Readme)
    --     end,
    -- },
}
