return {
    {
        'akinsho/toggleterm.nvim',
        name = 'toggleterm',
        event = 'VeryLazy',
        version = '*',
        config = function()
            require('toggleterm').setup()

            vim.api.nvim_create_autocmd('QuitPre', { -- closes terminal if open on exit
                group = vim.api.nvim_create_augroup('close_terminal_on_exit', { clear = true }),
                desc = 'Close Terminal on Exit',
                pattern = '*',
                callback = function()
                    local ui = require('toggleterm.ui')
                    local terms = require('toggleterm.terminal').get_all()

                    if ui.find_open_windows() then
                        for _, term in pairs(terms) do
                            term:close()
                        end
                    end
                end,
            })
            vim.keymap.set('n', '<leader>tt', '<cmd>ToggleTerm dir=%:p:h<CR>', { desc = '[T]erminal' })
            vim.keymap.set(
                'n',
                '<leader>tf',
                '<cmd>ToggleTerm direction=float dir=%:p:h<CR>',
                { desc = '[F]loating Terminal' }
            )
        end,
    },
}
