return {
    {
        'echasnovski/mini.sessions',
        version = '*',
        event = 'VeryLazy',
        opts = {},
    },

    {
        'echasnovski/mini.ai',
        version = false,
        event = 'VeryLazy',
    },

    {
        'echasnovski/mini.align',
        version = '*',
        event = 'VeryLazy',
        config = function()
            require('mini.align').setup()
        end,
    },

    {
        'echasnovski/mini.splitjoin',
        version = '*',
        event = 'VeryLazy',
        config = function()
            require('mini.splitjoin').setup({
                mappings = {
                    toggle = 'gS',
                    split = 'gs',
                    -- join = 'gj',
                },
            })
        end,
    },

    {
        'echasnovski/mini.pairs',
        enabled = false,
        event = 'VeryLazy',
        opts = {
            modes = { insert = true, command = true, terminal = false },
            -- skip autopair when next character is one of these
            skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
            -- skip autopair when the cursor is inside these treesitter nodes
            skip_ts = { 'string' },
            -- skip autopair when next character is closing pair
            -- and there are more closing pairs than opening pairs
            skip_unbalanced = true,
            -- better deal with markdown code blocks
            markdown = true,
        },
        -- config = function(_, opts)
        --   LazyVim.mini.pairs(opts)
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
        'echasnovski/mini.icons',
        lazy = true,
        opts = {
            file = {
                ['.keep'] = { glyph = '󰊢', hl = 'MiniIconsGrey' },
                ['devcontainer.json'] = { glyph = '', hl = 'MiniIconsAzure' },
            },
            filetype = {
                dotenv = { glyph = '', hl = 'MiniIconsYellow' },
            },
        },
        init = function()
            package.preload['nvim-web-devicons'] = function()
                require('mini.icons').mock_nvim_web_devicons()
                return package.loaded['nvim-web-devicons']
            end
        end,
    },

    { -- fun scope animations
        'echasnovski/mini.indentscope',
        version = '*', -- wait till new 0.7.0 release to put it back on semver
        enabled = false,
        event = 'VeryLazy',
        config = function()
            local indent_scope = require('mini.indentscope')
            indent_scope.setup({
                -- symbol = '▏',
                symbol = '▎',
                -- symbol = '│',
                options = {
                    border = 'both',
                    indent_at_cursor = true,
                    try_as_border = true,
                },
                draw = {
                    delay = 50,
                    -- animation = require('mini.indentscope').gen_animation.exponential({
                    --     easing = 'out',
                    --     duration = 100,
                    --     unit = 'total',
                    -- })
                },
            })
            indent_scope.gen_animation.exponential({
                easing = 'out',
                duration = 100,
                unit = 'step',
            })
        end,
        init = function()
            vim.api.nvim_create_autocmd('filetype', {
                pattern = {
                    'alpha',
                    'dashboard',
                    'fzf',
                    'help',
                    'lazy',
                    'lazyterm',
                    'mason',
                    'neo-tree',
                    'notify',
                    'toggleterm',
                    'Trouble',
                    'trouble',
                },
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
            })
        end,
    },
}
