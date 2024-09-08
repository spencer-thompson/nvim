return {

    {
        'nvim-neo-tree/neo-tree.nvim',
        name = 'neo-tree',
        branch = 'v3.x',
        event = 'VeryLazy',
        dependencies = {
            { 'nvim-lua/plenary.nvim', name = 'plenary' },
            { 'nvim-tree/nvim-web-devicons' }, -- not strictly required, but recommended
            { 'MunifTanjim/nui.nvim', name = 'nui' },
            -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        },
        -- config = function()
        -- require('neo-tree').setup({
        --     close_if_last_window = true,
        --     sources = { 'filesystem', 'buffers', 'git_status', 'document_symbols' },
        --     -- default_component_configs = {
        --     --     indent = {
        --     --         indent_size = 4,
        --     --     }
        --     -- }
        -- })
        -- end,
    },
    {
        'echasnovski/mini.files',
        version = '*',
        event = 'VeryLazy',
        opts = {
            mappings = {
                close = 'q',
                go_in = 'l',
                go_in_plus = '<CR>',
                go_out = 'H',
                go_out_plus = 'h',
                mark_goto = "'",
                mark_set = 'm',
                reset = '<BS>',
                reveal_cwd = '@',
                show_help = 'g?',
                synchronize = '=',
                trim_left = '<',
                trim_right = '>',
            },
            windows = {
                preview = true,
                width_focus = 30,
                width_nofocus = 15,
                width_preview = 50,
            },
        },
        config = function(_, opts)
            require('mini.files').setup(opts)

            local map_split = function(buf_id, lhs, direction, close_on_file)
                local rhs = function()
                    -- Make new window and set it as target
                    local new_target_window
                    local cur_target_window = require('mini.files').get_target_window()
                    if cur_target_window ~= nil then
                        vim.api.nvim_win_call(cur_target_window, function()
                            vim.cmd('belowright ' .. direction .. ' split')
                            new_target_window = vim.api.nvim_get_current_win()
                        end)

                        require('mini.files').set_target_window(new_target_window)
                        require('mini.files').go_in({ close_on_file = close_on_file })
                    end
                end

                -- Adding `desc` will result into `show_help` entries
                local desc = 'Split ' .. direction
                vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
            end

            vim.api.nvim_create_autocmd('User', {
                pattern = 'MiniFilesBufferCreate',
                callback = function(args)
                    local buf_id = args.data.buf_id
                    -- Tweak keys to your liking
                    map_split(buf_id, 'J', 'horizontal', true)
                    map_split(buf_id, 'L', 'vertical', true)
                end,
            })
        end,
    },
    {
        'stevearc/oil.nvim',
        name = 'oil',
        event = 'VeryLazy',
        opts = {},
        -- Optional dependencies
        dependencies = { 'nvim-tree/nvim-web-devicons' },
    },
    {
        'folke/flash.nvim',
        -- Quick motions/movement
        name = 'flash',
        event = 'VeryLazy',
        vscode = true,
        opts = {
            label = {
                after = false,
                before = true,
            },
        },
        keys = {
            {
                's',
                mode = { 'n', 'x', 'o' },
                function()
                    require('flash').jump()
                end,
                desc = 'Flash',
            },
            {
                'S',
                mode = { 'n', 'o', 'x' },
                function()
                    require('flash').treesitter()
                end,
                desc = 'Flash Treesitter',
            },
            {
                'r',
                mode = 'o',
                function()
                    require('flash').remote()
                end,
                desc = 'Remote Flash',
            },
            {
                'R',
                mode = { 'o', 'x' },
                function()
                    require('flash').treesitter_search()
                end,
                desc = 'Treesitter Search',
            },
            {
                '<c-s>',
                mode = { 'c' },
                function()
                    require('flash').toggle()
                end,
                desc = 'Toggle Flash Search',
            },
        },
    },
    {
        'christoomey/vim-tmux-navigator',
        name = 'tmux-navigator',
        lazy = false,
    },
}
