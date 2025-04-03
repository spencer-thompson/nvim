return {
    {
        'folke/which-key.nvim',
        name = 'which-key',
        event = 'VeryLazy',
        -- lazy = true,
        -- dependencies = { 'echasnovski/mini.icons', version = false },
        config = function(opts)
            local wk = require('which-key')
            wk.setup({
                preset = 'modern',
                win = {
                    border = 'single',
                },
            })
            wk.add({
                { --B
                    { '<leader>b', group = 'buffer' },
                },
                { -- D
                    {
                        '<leader>db',
                        function()
                            require('dbee').toggle()
                            -- if not require('dbee').is_open() then
                            --     vim.cmd([[tabnew]])
                            --     vim.cmd([[Dbee]])
                            --     -- require('dbee').toggle()
                            -- end
                        end,
                        desc = '[D]ata[b]ase',
                    },
                },
                { -- E
                    { '<leader>E', '<cmd>Neotree toggle left<CR>', desc = 'File Tree' },
                    -- { '<leader>e', group = 'explore', icon = '󰙅' }, -- TODO: figure out icons
                    -- { '<leader>ee', '<cmd>Neotree toggle current<CR>', desc = 'File Tree' },
                    -- { '<leader>em', '<cmd>lua MiniFiles.open()<CR>', desc = 'File Tree' },
                },
                { -- F
                    { '<leader>f', group = 'find' },
                },
                { -- G
                    { '<leader>g', group = 'git' },
                },
                { -- J
                    { 'jk', hidden = true, mode = { 'v' } },
                },
                -- { -- L
                --     { '<leader>l', '<cmd>Lazy<CR>', desc = '[L]azy' },
                -- },
                { -- M
                    { '<leader>m', group = 'map' },
                },
                { -- N
                    { '<leader>n', group = 'notif' },
                },
                { -- S
                    { '<leader>s', group = 'show' },
                    { '<leader>sk', '<cmd>ShowkeysToggle<CR>', desc = '[S]how [K]eys' },
                },
                { -- T
                    { '<leader>t', group = 'toggle' },
                    {
                        '<leader>tn',
                        function()
                            vim.cmd([[tabnew]])
                            vim.ui.input({ prompt = 'New Tab Name: ' }, function(input)
                                vim.cmd('BufferLineTabRename ' .. input)
                            end)
                        end,
                        desc = '[N]ew Tab',
                    },
                },
                { -- V
                    { '<leader>v', desc = 'Select Treesitter Nodes' },
                },
            })
        end,
    },
}
