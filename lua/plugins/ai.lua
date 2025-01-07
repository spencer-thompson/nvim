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

    {
        'yetone/avante.nvim',
        event = 'VeryLazy',
        name = 'avante',
        enabled = false,
        lazy = true,
        version = false,
        opts = {
            -- add any opts here
            hints = { enabled = false },
        },
        build = 'make',
        -- keys = {
        --     {
        --         '<leader>aa',
        --         function()
        --             require('avante.api').ask()
        --         end,
        --         desc = 'avante: ask',
        --         mode = { 'n', 'v' },
        --     },
        --     {
        --         '<leader>ar',
        --         function()
        --             require('avante.api').refresh()
        --         end,
        --         desc = 'avante: refresh',
        --     },
        --     {
        --         '<leader>ae',
        --         function()
        --             require('avante.api').edit()
        --         end,
        --         desc = 'avante: edit',
        --         mode = 'v',
        --     },
        -- },
        dependencies = {
            'stevearc/dressing.nvim',
            'nvim-lua/plenary.nvim',
            'MunifTanjim/nui.nvim',
            'nvim-treesitter/nvim-treesitter',
            --- The below dependencies are optional,
            {
                -- support for image pasting
                'HakonHarnes/img-clip.nvim',
                lazy = true,
                name = 'img-clip',
                -- event = 'VeryLazy',
                opts = {
                    -- recommended settings
                    default = {
                        embed_image_as_base64 = false,
                        prompt_for_file_name = false,
                        drag_and_drop = {
                            insert_mode = true,
                        },
                        -- required for Windows users
                        use_absolute_path = true,
                    },
                },
            },
            {
                -- Make sure to setup it properly if you have lazy=true
                'MeanderingProgrammer/render-markdown.nvim',
                lazy = true,
                enabled = true,
                name = 'render-markdown',
                opts = {
                    file_types = { 'markdown', 'Avante' },
                },
                ft = { 'markdown', 'Avante' },
            },
        },
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
        enabled = true,
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
