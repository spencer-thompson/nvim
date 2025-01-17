return {
    { -- completion engine
        'saghen/blink.cmp',
        lazy = true,
        event = 'InsertEnter',
        dependencies = {
            'rafamadriz/friendly-snippets',
            'saghen/blink.compat',
            { 'niuiic/blink-cmp-rg.nvim', name = 'blink-cmp-rg' },
            { 'chrisgrieser/cmp-nerdfont', lazy = true },
        },

        -- use a release tag to download pre-built binaries
        version = 'v0.*',

        opts_extend = {
            'sources.completion.enabled_providers',
            'sources.compat',
            'sources.default',
        },

        opts = {
            keymap = {
                preset = 'default',
                ['<C-y>'] = { 'select_and_accept' },
                ['<C-k>'] = { 'select_prev', 'fallback' },
                ['<C-j>'] = { 'select_next', 'fallback' },
                ['<C-e>'] = { 'hide_documentation', 'hide' },
                ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
                ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
                ['<C-l>'] = {
                    function(cmp)
                        if cmp.snippet_active() then
                            return cmp.snippet_forward()
                        elseif not cmp.is_visible() then
                            return cmp.show({ providers = { 'snippets' } })
                        else
                            return cmp.select_and_accept()
                        end
                    end,
                },
                ['<C-h>'] = {
                    function(cmp)
                        if cmp.snippet_active() then
                            return cmp.snippet_backward()
                        elseif not cmp.is_visible() then
                            return cmp.show()
                        else
                            return cmp.show_documentation()
                        end
                    end,
                },
            },

            completion = {

                accept = {
                    -- experimental auto-brackets support
                    auto_brackets = {
                        enabled = true,
                    },
                },

                menu = {
                    max_height = 20,
                    winblend = vim.o.pumblend,
                    scrolloff = 5,
                    draw = {
                        treesitter = { 'lsp' },
                        components = {
                            kind_icon = {
                                ellipsis = false,
                                -- text = function(ctx)
                                --     local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                                --     return kind_icon
                                -- end,
                                -- Optionally, you may also use the highlights from mini.icons
                                -- highlight = function(ctx)
                                --     local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                                --     return hl
                                -- end,
                            },
                        },
                    },
                },
                ghost_text = {
                    enabled = true,
                },
            },
            -- snippets = { preset = 'mini_snippets' },

            sources = {
                default = {
                    'lsp',
                    'path',
                    'snippets',
                    'buffer',
                    'lazydev',
                    'ripgrep',
                    'nerdfont',
                },
                cmdline = function()
                    local type = vim.fn.getcmdtype()
                    -- Search forward and backward
                    if type == '/' or type == '?' then
                        return { 'buffer' }
                    end
                    -- Commands
                    if type == ':' then
                        return { 'cmdline' }
                    end
                    return {}
                end,
                providers = {
                    lsp = { fallbacks = { 'lazydev' } },
                    lazydev = {
                        name = 'LazyDev',
                        module = 'lazydev.integrations.blink',
                        score_offset = 100,
                    },
                    ripgrep = {
                        module = 'blink-cmp-rg',
                        name = 'Ripgrep',
                        score_offset = -10,
                        opts = {
                            -- `min_keyword_length` only determines whether to show completion items in the menu,
                            -- not whether to trigger a search. And we only has one chance to search.
                            prefix_min_len = 3,
                            get_command = function(context, prefix)
                                return {
                                    'rg',
                                    '--no-config',
                                    '--json',
                                    '--word-regexp',
                                    '--ignore-case',
                                    '--',
                                    prefix .. '[\\w_-]+',
                                    vim.fs.root(0, '.git') or vim.fn.getcwd(),
                                }
                            end,
                            get_prefix = function(context)
                                return context.line:sub(1, context.cursor[2]):match('[%w_-]+$') or ''
                            end,
                        },
                    },
                    nerdfont = {
                        name = 'nerdfont',
                        module = 'blink.compat.source',
                        transform_items = function(ctx, items)
                            -- TODO: check https://github.com/Saghen/blink.cmp/pull/253#issuecomment-2454984622
                            local kind = require('blink.cmp.types').CompletionItemKind.Text

                            for i = 1, #items do
                                items[i].kind = kind
                            end

                            return items
                        end,
                    },
                },
            },

            appearance = {
                use_nvim_cmp_as_default = false,
                nerd_font_variant = 'mono',
            },
        },
    },

    { -- make TODO + ":" a fancy colored comment.
        'folke/todo-comments.nvim',
        name = 'todo-comments',
        event = 'VeryLazy',
        dependecies = { 'nvim-lua/plenary.nvim', name = 'plenary' },
        opts = {
            keywords = {
                DONE = { icon = ' ', color = 'info' },
                TODO = { icon = '󰵚 ', color = 'info' },
            },
            merge_keywords = true,
        },
        keys = {
            {
                ']t',
                function()
                    require('todo-comments').jump_next()
                end,
                desc = 'Next todo comment',
            },
            {
                '[t',
                function()
                    require('todo-comments').jump_prev()
                end,
                desc = 'Previous todo comment',
            },
        },
        config = true,
    },

    { -- This thing is so awesome
        'rachartier/tiny-inline-diagnostic.nvim',
        name = 'tiny-inline-diagnostic',
        event = 'VeryLazy', -- Or `LspAttach`
        priority = 1000,
        config = function()
            require('tiny-inline-diagnostic').setup({
                hi = {
                    background = 'None',
                },
                options = {
                    multiple_diag_under_cursor = true,
                    break_line = {
                        enabled = true,
                        after = 50,
                    },
                },
            })
        end,
    },

    { -- linting, but I didn't like it telling me what to do lol
        'mfussenegger/nvim-lint',
        enabled = false,
        name = 'lint',
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
            local lint = require('lint')
            lint.linters_by_ft = {
                markdown = { 'vale' },
                python = { 'ruff' },
            }

            local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

            vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
                group = lint_augroup,
                callback = function()
                    lint.try_lint()
                end,
            })
        end,
    },

    { -- debugging
        'mfussenegger/nvim-dap',
        name = 'dap',
        -- event = "VeryLazy",
        lazy = true,
    },

    { -- fancy undo tree, shows undo history as a tree data structure
        'mbbill/undotree',
        lazy = true,
        name = 'undotree',
        event = 'VeryLazy',
        config = function()
            vim.keymap.set('n', '<leader>ut', vim.cmd.UndotreeToggle, { desc = '[U]ndo[t]ree' })
        end,
    },

    {
        'kylechui/nvim-surround',
        enabled = true,
        name = 'surround',
        version = '*', -- Use for stability; omit to use `main` branch for the latest features
        event = 'VeryLazy',
        config = function()
            require('nvim-surround').setup({
                keymaps = {
                    insert = false,
                    insert_line = false,
                    normal = 'ys',
                    normal_cur = 'yss',
                    normal_line = 'yS',
                    normal_cur_line = 'ySS',
                    visual = 'S',
                    visual_line = false,
                },
            })
        end,
    },

    {
        'windwp/nvim-autopairs',
        name = 'autopairs',
        event = 'InsertEnter',
        enabled = false,
        -- opts = { }, -- this is equalent to setup({}) function
        config = function()
            require('nvim-autopairs').setup({})

            local Rule = require('nvim-autopairs.rule')
            local npairs = require('nvim-autopairs')
            -- local cond = require('nvim-autopairs.conds')

            -- npairs.add_rules({
            --     Rule('$', '$', { 'tex', 'latex', 'typst' }),
            --     -- Rule("'", "'", '-typst'), -- :with_pair(cond.not_filetypes({ 'typst' })),
            -- })
            -- require('nvim-autopairs').get_rules("'")[1].not_filetypes = { 'typst' }
        end,
    },

    { 'tpope/vim-sleuth', event = 'VeryLazy' }, -- auto adjust shift and tabs
    { 'tpope/vim-repeat', name = 'repeat', event = 'VeryLazy' }, -- better repeating with plugins
}
