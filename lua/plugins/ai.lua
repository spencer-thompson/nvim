-- ai slop, I should just delete this
return {

    {
        'zbirenbaum/copilot.lua',
        enabled = false,
        cmd = 'Copilot',
        event = 'InsertEnter',
        opts = {
            suggestion = { enabled = false },
            panel = { enabled = false },
            filetypes = {
                markdown = true,
                help = true,
            },
        },
    },

    {
        'olimorris/codecompanion.nvim',
        name = 'codecompanion',
        event = 'VeryLazy',
        enabled = false,
        config = function()
            require('codecompanion').setup({
                display = {
                    chat = {
                        -- show_settings = true,
                        -- start_in_insert_mode = true,

                        window = {
                            opts = {
                                number = false,
                                rnu = false,
                            },
                        },
                    },
                    diff = {
                        enabled = true,
                        close_chat_at = 240, -- Close an open chat buffer if the total columns of your display are less than...
                        layout = 'vertical', -- vertical|horizontal split for default provider
                        opts = { 'internal', 'filler', 'closeoff', 'algorithm:patience', 'followwrap', 'linematch:120' },
                        provider = 'mini_diff', -- default|mini_diff
                    },
                },
                strategies = {
                    chat = {
                        adapter = 'openai',
                        -- tools = {
                        --     ['mcp'] = {
                        --         -- calling it in a function would prevent mcphub from being loaded before it's needed
                        --         callback = function()
                        --             return require('mcphub.extensions.codecompanion')
                        --         end,
                        --         description = 'Call tools and resources from the MCP Servers',
                        --         opts = {
                        --             requires_approval = true,
                        --         },
                        --     },
                        -- },
                    },
                    inline = {
                        adapter = 'copilot',
                    },
                },
            })

            vim.keymap.set(
                { 'n', 'v' },
                '<leader>cc',
                '<cmd>CodeCompanionChat Toggle<cr>',
                { desc = 'AI [C]hat', noremap = true, silent = true }
            )
            vim.keymap.set(
                { 'n', 'v' },
                '<leader>ca',
                '<cmd>CodeCompanionActions<cr>',
                { desc = 'AI [A]ctions', noremap = true, silent = true }
            )
            vim.cmd([[cab cc CodeCompanion]])
        end,
        dependencies = {
            { 'nvim-lua/plenary.nvim', name = 'plenary' },
            'nvim-treesitter/nvim-treesitter',
            -- 'ravitemer/mcphub.nvim',
            {
                'OXY2DEV/markview.nvim',
                name = 'markview',
                event = 'VeryLazy',
                -- lazy = false,
                opts = {
                    preview = {
                        filetypes = { 'codecompanion', 'mcphub' },
                        ignore_buftypes = {},
                        icon_provider = 'mini',
                        modes = { 'n', 'no', 'c', 'i' },
                    },
                },
            },
        },
    },
    {
        'ravitemer/mcphub.nvim',
        name = 'mcphub',
        enabled = false,
        event = 'VeryLazy',
        dependencies = {
            'nvim-lua/plenary.nvim', -- Required for Job and HTTP requests
        },
        -- cmd = "MCPHub", -- lazily start the hub when `MCPHub` is called
        build = 'npm install -g mcp-hub@latest', -- Installs required mcp-hub npm module
        config = function()
            require('mcphub').setup({
                -- Required options
                port = 3000, -- Port for MCP Hub server
                config = vim.fn.expand('~/dotfiles/.config/nvim/mcpservers.json'), -- Absolute path to config file

                -- Optional options
                on_ready = function(hub)
                    -- Called when hub is ready
                end,
                on_error = function(err)
                    -- Called on errors
                end,
                log = {
                    level = vim.log.levels.WARN,
                    to_file = false,
                    file_path = nil,
                    prefix = 'MCPHub',
                },
            })
        end,
    },
}
