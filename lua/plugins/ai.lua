-- ai slop, I should just delete this
return {

    { -- requires subscription
        'github/copilot.vim',
        name = 'copilot',
        enabled = false,
        -- event = 'VeryLazy',
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
        enabled = false,
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
        enabled = false,
        lazy = true,
        cmd = { 'ChatGPT', 'ChatGPTRun', 'ChatGPTEditWithInstruction' },
        dependencies = {
            'nvim-lua/plenary.nvim',
            'MunifTanjim/nui.nvim',
        },
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
        keys = {
            {
                '<leader>c',
                function()
                    vim.cmd([[ChatGPT]])
                end,
                desc = '[C]hatGPT',
                mode = { 'n', 'v' },
            },
            -- {
            --     '<leader>ar',
            --     function()
            --         require('chatgpt').
            --     end,
            --     desc = 'avante: refresh',
            -- },
        },
    },
}
