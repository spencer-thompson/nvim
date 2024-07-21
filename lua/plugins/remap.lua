return {
    {
        'folke/which-key.nvim',
        name = 'which-key',
        event = 'VeryLazy',
        -- lazy = true,
        dependencies = { 'echasnovski/mini.icons', version = false },
        -- opts = {
        --     preset = 'modern',
        -- },
        config = function(opts)
            local wk = require('which-key')
            wk.setup({
                preset = 'modern',
            })
            wk.add({
                { -- E
                    { '<leader>e', group = 'explore', icon = '󰙅' }, -- TODO: figure out icons
                    { '<leader>ee', '<cmd>Neotree toggle current<CR>', desc = 'File Tree' },
                },
                { -- F
                    { '<leader>f', group = 'find' },
                },
                { -- L
                    { '<leader>l', '<cmd>Lazy<CR>', desc = '[L]azy' },
                },
                { -- T
                    { '<leader>t', group = 'trouble' },
                },
                { -- V
                    { '<leader>v', desc = 'Select Treesitter Nodes' },
                },
                { -- Z
                    { '<leader>Z', '<cmd>ZenMode<CR>', desc = '[Z]en Mode' },
                },
            })
        end,
        -- config = function(opts)
        --     local wk = require('which-key')
        --     wk.setup(opts)
        -- wk.register( -- help remembering maps
        --     { -- add plugin map groups
        --         A = { 'Swap Previous Parameter' },
        --         a = { 'Swap Next Parameter' },
        --         c = {
        --             name = 'chat',
        --             c = { '<cmd>ChatGPT<CR>', 'ChatGPT' },
        --             e = { '<cmd>ChatGPTEditWithInstruction<CR>', 'Edit with instruction', mode = { 'n', 'v' } },
        --             g = { '<cmd>ChatGPTRun grammar_correction<CR>', 'Grammar Correction', mode = { 'n', 'v' } },
        --             t = { '<cmd>ChatGPTRun translate<CR>', 'Translate', mode = { 'n', 'v' } },
        --             k = { '<cmd>ChatGPTRun keywords<CR>', 'Keywords', mode = { 'n', 'v' } },
        --             d = { '<cmd>ChatGPTRun docstring<CR>', 'Docstring', mode = { 'n', 'v' } },
        --             D = { '<cmd>Copilot disable<CR>', 'Disable Copilot' },
        --             a = { '<cmd>ChatGPTRun add_tests<CR>', 'Add Tests', mode = { 'n', 'v' } },
        --             o = { '<cmd>ChatGPTRun optimize_code<CR>', 'Optimize Code', mode = { 'n', 'v' } },
        --             s = { '<cmd>ChatGPTRun summarize<CR>', 'Summarize', mode = { 'n', 'v' } },
        --             f = { '<cmd>ChatGPTRun fix_bugs<CR>', 'Fix Bugs', mode = { 'n', 'v' } },
        --             x = { '<cmd>ChatGPTRun explain_code<CR>', 'Explain Code', mode = { 'n', 'v' } },
        --             r = { '<cmd>ChatGPTRun roxygen_edit<CR>', 'Roxygen Edit', mode = { 'n', 'v' } },
        --             l = {
        --                 '<cmd>ChatGPTRun code_readability_analysis<CR>',
        --                 'Code Readability Analysis',
        --                 mode = { 'n', 'v' },
        --             },
        --         },
        --         d = { name = 'dashboard' },
        --         e = {
        --             name = 'explore',
        --             e = { '<cmd>Neotree toggle current<CR>', 'File Tree' },
        --             f = { '<cmd>Neotree toggle float<CR>', 'Float' },
        --             -- g = { "<cmd>Neotree toggle float<CR>", "Float" },
        --             l = { '<cmd>Neotree toggle<CR>', 'Left' },
        --             o = { '<cmd>Oil<CR>', 'Oil' },
        --             r = { '<cmd>Neotree toggle right<CR>', 'Right' },
        --         },
        --         f = { name = 'find' },
        --         -- F = { name = "format" },
        --         g = {
        --             name = 'git',
        --             d = { '<cmd>DiffviewOpen<CR>', 'Diff' },
        --             -- f = { "<cmd>"},
        --             g = { '<cmd>G<CR>', 'Fugitive' },
        --         },
        --         l = { '<cmd>Lazy<CR>', '[L]azy' },
        --         p = { 'Paste' },
        --         s = { name = 'split' },
        --         t = {
        --             name = 'toggle',
        --             f = { '<cmd>ToggleTerm direction=float<CR>', '[F]loating' },
        --             t = { '<cmd>ToggleTerm<CR>', '[T]erminal' },
        --             w = { '<cmd>Twilight<CR>', 'T[w]ilight' },
        --         },
        --         v = { 'Treesitter Selection' },
        --         Z = { '<cmd>ZenMode<CR>', '[Z]en Mode' },
        --     },
        --     { prefix = '<leader>' }
        -- )
        -- end,
    },
}
