return {
    { -- completion engine
        'saghen/blink.cmp',
        lazy = true,
        event = 'InsertEnter',
        dependencies = {
            'rafamadriz/friendly-snippets',
            'saghen/blink.compat',
            { 'niuiic/blink-cmp-rg.nvim', name = 'blink-cmp-rg', lazy = true },
            { 'chrisgrieser/cmp-nerdfont', lazy = true },
            { 'moyiz/blink-emoji.nvim', name = 'blink-emoji', lazy = true },
            { 'mikavilpas/blink-ripgrep.nvim', name = 'blink-ripgrep', lazy = true },
            {
                'Kaiser-Yang/blink-cmp-dictionary',
                dependencies = { 'nvim-lua/plenary.nvim' },
            },
        },

        -- use a release tag to download pre-built binaries
        version = 'v0.*',

        opts_extend = {
            'sources.completion.enabled_providers',
            'sources.compat',
            'sources.default',
        },

        opts = {
            enabled = function()
                return not vim.tbl_contains({ 'minifiles' }, vim.bo.filetype)
                    and vim.bo.buftype ~= 'prompt'
                    and vim.b.completion ~= false
            end,

            keymap = {
                preset = 'default',
                ['<C-e>'] = { 'cancel', 'hide' },
                ['<C-y>'] = { 'select_and_accept' },
                ['<C-k>'] = { 'select_prev', 'fallback' },
                ['<C-j>'] = { 'select_next', 'fallback' },
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
                    'hide_documentation', -- based
                },
            },

            -- signature = {
            --     enabled = false,
            --     window = {
            --         show_documentation = true,
            --         winblend = vim.o.pumblend,
            --         border = 'single',
            --     },
            -- },

            completion = {

                accept = {
                    -- experimental auto-brackets support
                    auto_brackets = {
                        enabled = true,
                    },
                },

                -- list = {
                --     selection = {
                --         preselect = function(ctx)
                --             return ctx.mode == 'cmdline'
                --         end,
                --         auto_insert = function(ctx)
                --             return ctx.mode ~= 'cmdline'
                --         end,
                --     },
                -- },

                menu = {
                    max_height = 25,
                    winblend = vim.o.pumblend,
                    auto_show = true,
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
                documentation = {
                    window = {
                        border = 'single',
                        winblend = vim.o.pumblend,
                    },
                },
                ghost_text = {
                    enabled = false,
                },
            },
            -- snippets = { preset = 'mini_snippets' },

            sources = {
                default = function()
                    local sources = {
                        'dictionary',
                        'lsp',
                        'buffer',
                        'path',
                        'emoji',
                        'nerdfont',
                        'snippets',
                        'lazydev',
                        'ripgrep',
                    }

                    local ok, node = pcall(vim.treesitter.get_node)
                    if vim.bo.filetype == 'typst' then
                        return sources
                    elseif
                        ok
                        and node
                        and vim.tbl_contains(
                            { 'comment', 'line_comment', 'block_comment', 'string', 'string_content' },
                            node:type()
                        )
                    then
                        return {
                            'path',
                            'emoji',
                            'ripgrep',
                            'nerdfont',
                            'dictionary',
                        }
                    else
                        return sources
                    end

                    return sources
                end,
                providers = {
                    lazydev = {
                        name = 'LazyDev',
                        module = 'lazydev.integrations.blink',
                        max_items = 12,
                        score_offset = 20,
                    },
                    dictionary = {
                        max_items = 500,
                        module = 'blink-cmp-dictionary',
                        name = 'Dict',
                        score_offset = -20,

                        transform_items = function(ctx, items)
                            local kind = require('blink.cmp.types').CompletionItemKind.EnumMember

                            for i = 1, #items do
                                items[i].kind = kind
                            end

                            return items
                        end,

                        min_keyword_length = 3,

                        opts = {
                            -- Specify the dictionary files' path
                            -- example: { vim.fn.expand('~/.config/nvim/dictionary/words.dict') }
                            dictionary_files = { vim.fn.expand('~/.config/nvim/dict/valid_words.txt') },
                            -- All .txt files in these directories will be treated as dictionary files
                            -- example: { vim.fn.expand('~/.config/nvim/dictionary') }
                            dictionary_directories = nil,
                            separate_output = function(output)
                                local items = {}
                                for line in output:gmatch('[^\r\n]+') do
                                    local word = line
                                    table.insert(items, {
                                        label = word,
                                        insert_text = word,
                                        -- If you want to disable the documentation feature, just set it to nil
                                        documentation = {
                                            get_command = 'wn',
                                            get_command_args = {
                                                word,
                                                '-over',
                                            },
                                            ---@diagnostic disable-next-line: redefined-local
                                            resolve_documentation = function(output)
                                                return output
                                            end,
                                        },
                                    })
                                end
                                return items
                            end,
                        },
                    },
                    ripgrep = {
                        module = 'blink-ripgrep',
                        name = 'Ripgrep',
                        score_offset = -20,
                        opts = {
                            -- the minimum length of the current word to start searching
                            prefix_min_len = 3,

                            -- The number of lines to show around each match in the preview (documentation) window. Before and after
                            context_size = 5,

                            -- The maximum file size of a file that ripgrep should include in its search.
                            max_filesize = '1M',

                            -- Specifies how to find the root of the project where the ripgrep search will start from.
                            project_root_marker = '.git',

                            -- Enable fallback to neovim cwd if project_root_marker is not found. Default: `true`, which means to use the cwd.
                            project_root_fallback = true,

                            -- The casing to use for the search in a format that ripgrep accepts. Defaults to "--ignore-case".
                            search_casing = '--ignore-case',

                            -- (advanced) Any additional options you want to give to ripgrep.
                            additional_rg_options = {},

                            -- When a result is found for a file whose filetype does not have a treesitter parser installed, fall back to regex based highlighting that is bundled in Neovim.
                            fallback_to_regex_highlighting = true,

                            -- Absolute root paths where the rg command will not be executed.
                            ignore_paths = { 'dict/' },

                            -- Any additional paths to search in, in addition to the project root.
                            additional_paths = {},
                            debug = false,
                        },
                        -- (optional) customize how the results are displayed.
                        transform_items = function(ctx, items)
                            local kind = require('blink.cmp.types').CompletionItemKind.File

                            for i = 1, #items do
                                items[i].kind = kind
                            end

                            return items
                        end,
                    },
                    nerdfont = {
                        name = 'nerdfont',
                        module = 'blink.compat.source',
                        transform_items = function(ctx, items)
                            -- check https://github.com/Saghen/blink.cmp/pull/253#issuecomment-2454984622
                            local kind = require('blink.cmp.types').CompletionItemKind.Color

                            for i = 1, #items do
                                items[i].kind = kind
                            end

                            return items
                        end,
                    },
                    emoji = {
                        module = 'blink-emoji',
                        name = 'Emoji',
                        score_offset = 0,

                        transform_items = function(ctx, items)
                            local kind = require('blink.cmp.types').CompletionItemKind.Color

                            for i = 1, #items do
                                items[i].kind = kind
                            end

                            return items
                        end,

                        opts = { insert = true },
                    },
                },
            },
            cmdline = {
                sources = function()
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
            },

            appearance = {
                use_nvim_cmp_as_default = false,
                nerd_font_variant = 'mono',
                kind_icons = require('icons').symbol_kinds,
                -- kind_icons = {
                --     Class = '󱡠',
                --     Color = '󰏘',
                --     Constant = '󰏿',
                --     Constructor = '󰒓',
                --     Enum = '󰦨',
                --     EnumMember = '󰦨',
                --     Event = '󱐋',
                --     Field = '󰜢',
                --     File = '󰈔',
                --     Folder = '󰉋',
                --     Function = '󰊕',
                --     Interface = '󱡠',
                --     Keyword = '󰻾',
                --     Method = '󰊕',
                --     Module = '󰅩',
                --     Operator = '󰪚',
                --     Property = '󰖷',
                --     Reference = '󰬲',
                --     Snippet = '󱄽',
                --     Struct = '󱡠',
                --     Text = '󰉿',
                --     TypeParameter = '󰬛',
                --     Unit = '󰪚',
                --     Value = '󰦨',
                --     Variable = '󰆦',
                -- },
                -- kind_icons = require('icons').symbol_kinds,
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
                preset = 'classic',
                hi = {
                    background = 'None',
                },
                transparent_bg = true,
                options = {
                    format = function(diagnostic)
                        return diagnostic.message .. ' [' .. diagnostic.source .. ']'
                    end,
                    show_source = false,
                    use_icons_from_diagnostic = false,
                    multiple_diag_under_cursor = true,
                    -- break_line = {
                    --     enabled = true,
                    --     after = 50,
                    -- },
                    overflow = {
                        mode = 'wrap',
                        padding = 12,
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
        enabled = false,
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
