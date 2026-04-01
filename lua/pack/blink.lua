vim.pack.add({
    { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range('*') },
    { src = 'https://github.com/xzbdmw/colorful-menu.nvim' },
    { src = 'https://github.com/mikavilpas/blink-ripgrep.nvim' },
})

require('blink-ripgrep').setup({})

require('colorful-menu').setup({})

require('blink.cmp').setup({
    enabled = function()
        return not vim.tbl_contains({ 'minifiles', 'sql' }, vim.bo.filetype)
            and vim.bo.buftype ~= 'prompt'
            and vim.b.completion ~= false
    end,

    keymap = {
        preset = 'default',
        ['<C-e>'] = { 'cancel', 'hide' },
        ['<C-y>'] = { 'show', 'select_and_accept' },
        ['<C-k>'] = { 'select_prev', 'fallback' },
        ['<C-j>'] = { 'select_next', 'fallback' },
        ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
        ['<C-l>'] = {
            function(cmp)
                if cmp.snippet_active() then
                    cmp.snippet_forward()
                    return true
                end
            end,
            function(cmp)
                if not cmp.is_menu_visible() then
                    cmp.show()
                    return true
                end
            end,
            function(cmp)
                if cmp.is_menu_visible() then
                    cmp.show_documentation()
                    return true
                end
            end,
            -- function(cmp)
            --     vim.lsp.buf.signature_help()
            -- end,
            -- function(cmp)
            --     -- if not cmp.is_visible() then
            --     cmp.show({ providers = { 'copilot' } })
            --     return true
            --     -- end
            -- end,
            -- function(cmp)
            --     if not cmp.is_visible() then
            --         cmp.show({ providers = { 'snippets' } })
            --         return true
            --     end
            -- end,
            -- 'select_and_accept',
            -- 'cancel',
            -- 'show_and_insert',
            'fallback',
        },
        ['<C-h>'] = {
            'show',
            function(cmp)
                if cmp.snippet_active() then
                    cmp.snippet_backward()
                    return true
                end
            end,
            function(cmp)
                if cmp.is_menu_visible() and not cmp.is_documentation_visible() then
                    cmp.hide()
                    return true
                elseif cmp.is_menu_visible() and cmp.is_documentation_visible() then
                    cmp.hide_documentation()
                    return true
                end
            end,
            -- 'fallback',
            --
        },
    },
    cmdline = {
        completion = {
            ghost_text = { enabled = true },
        },
        keymap = {
            preset = 'inherit',
            ['<C-e>'] = { 'cancel', 'hide' },
            ['<C-y>'] = { 'show', 'select_and_accept' },
            ['<C-k>'] = { 'select_prev' },
            ['<C-j>'] = { 'select_next' },
            ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
            ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
            ['<C-l>'] = {
                function(cmp)
                    if cmp.snippet_active() then
                        cmp.snippet_forward()
                        return true
                    end
                end,
                function(cmp)
                    if not cmp.is_menu_visible() then
                        cmp.show()
                        return true
                    end
                end,
                function(cmp)
                    if cmp.is_menu_visible() then
                        cmp.show_documentation()
                        return true
                    end
                end,
                -- function(cmp)
                --     if not cmp.is_visible() then
                --         cmp.show({ providers = { 'snippets' } })
                --         return true
                --     end
                -- end,
                -- 'select_and_accept',
                -- 'cancel',
                -- 'show_and_insert',
                'fallback',
            },
            ['<C-h>'] = {
                'show',
                function(cmp)
                    if cmp.snippet_active() then
                        cmp.snippet_backward()
                        return true
                    end
                end,
                function(cmp)
                    if cmp.is_menu_visible() and not cmp.is_documentation_visible() then
                        cmp.hide()
                        return true
                    elseif cmp.is_menu_visible() and cmp.is_documentation_visible() then
                        cmp.hide_documentation()
                        return true
                    end
                end,
                -- 'fallback',
            },
        },
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

    -- signature = {
    --     enabled = true,
    --     window = {
    --         show_documentation = true,
    --         winblend = vim.o.pumblend,
    --         border = 'single',
    --     },
    -- },

    fuzzy = { implementation = 'prefer_rust_with_warning' },

    completion = {

        trigger = {
            show_on_keyword = true,
        },

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
            max_height = 15,
            winblend = vim.o.pumblend,
            auto_show = true,
            scrolloff = 8,
            border = 'none',
            draw = {
                treesitter = { 'lsp' },
                columns = { { 'kind_icon' }, { 'label', gap = 1 } },
                components = {
                    label = {
                        width = { fill = true, max = 50 },
                        text = function(ctx)
                            return require('colorful-menu').blink_components_text(ctx)
                        end,
                        highlight = function(ctx)
                            return require('colorful-menu').blink_components_highlight(ctx)
                        end,
                    },
                    -- kind_icon = {
                    --
                    --     text = function(ctx)
                    --         local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                    --         return kind_icon
                    --     end,
                    --     -- (optional) use highlights from mini.icons
                    --     highlight = function(ctx)
                    --         local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                    --         return hl
                    --     end,
                    -- },
                    -- kind = {
                    --     -- (optional) use highlights from mini.icons
                    --     highlight = function(ctx)
                    --         local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                    --         return hl
                    --     end,
                    -- },
                },
                -- components = {
                --     kind_icon = {
                --         ellipsis = false,
                --         -- text = function(ctx)
                --         --     local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                --         --     return kind_icon
                --         -- end,
                --         -- Optionally, you may also use the highlights from mini.icons
                --         -- highlight = function(ctx)
                --         --     local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                --         --     return hl
                --         -- end,
                --     },
                -- },
            },
        },
        documentation = {
            window = {
                border = 'single',
                winblend = vim.o.pumblend,
            },
        },
        ghost_text = {
            enabled = true,
            show_with_menu = true,
        },
    },
    -- snippets = { preset = 'mini_snippets' },

    sources = {
        default = function()
            local sources = {
                -- 'dictionary',
                'lsp',
                'buffer',
                'path',
                'omni',
                -- 'emoji',
                -- 'nerdfont',
                'snippets',
                -- 'lazydev',
                'ripgrep',
                -- 'copilot',
            }

            -- local ok, node = pcall(vim.treesitter.get_node)
            -- if vim.bo.filetype == 'typst' then
            --     return sources
            -- elseif
            --     ok
            --     and node
            --     and vim.tbl_contains(
            --         { 'comment', 'line_comment', 'block_comment', 'string', 'string_content' },
            --         node:type()
            --     )
            -- then
            --     return {
            --         'path',
            --         'emoji',
            --         'ripgrep',
            --         'nerdfont',
            --         'dictionary',
            --     }
            -- else
            --     return sources
            -- end

            return sources
        end,
        providers = {
            lsp = {
                score_offset = 3,
            },
            snippets = {
                score_offset = 3,
            },
            -- lazydev = {
            --     name = 'LazyDev',
            --     module = 'lazydev.integrations.blink',
            --     max_items = 12,
            --     score_offset = 3,
            -- },
            copilot = {
                name = 'Copilot',
                module = 'blink-copilot',
                score_offset = -3, -- lol copilot bad
                async = true,
                -- min_keyword_length = 3,
            },
            -- dictionary = {
            --     max_items = 500,
            --     module = 'blink-cmp-dictionary',
            --     name = 'Dict',
            --     score_offset = -2,
            --     async = true,
            --
            --     transform_items = function(ctx, items)
            --         -- local kind = require('blink.cmp.types').CompletionItemKind.EnumMember
            --
            --         local icon = require('icons').misc.book
            --
            --         for i = 1, #items do
            --             -- items[i].kind = kind
            --             items[i].kind_icon = icon
            --             items[i].kind_name = 'Dictionary'
            --         end
            --
            --         return items
            --     end,
            --
            --     min_keyword_length = 3,
            --
            --     opts = {
            --         -- Specify the dictionary files' path
            --         -- example: { vim.fn.expand('~/.config/nvim/dictionary/words.dict') }
            --         dictionary_files = { vim.fn.expand('~/.config/nvim/dict/valid_words.txt') },
            --         -- All .txt files in these directories will be treated as dictionary files
            --         -- example: { vim.fn.expand('~/.config/nvim/dictionary') }
            --         dictionary_directories = nil,
            --         separate_output = function(output)
            --             local items = {}
            --             for line in output:gmatch('[^\r\n]+') do
            --                 local word = line
            --                 table.insert(items, {
            --                     label = word,
            --                     insert_text = word,
            --                     -- If you want to disable the documentation feature, just set it to nil
            --                     documentation = {
            --                         get_command = 'wn',
            --                         get_command_args = {
            --                             word,
            --                             '-over',
            --                         },
            --                         ---@diagnostic disable-next-line: redefined-local
            --                         resolve_documentation = function(output)
            --                             return output
            --                         end,
            --                     },
            --                 })
            --             end
            --             return items
            --         end,
            --     },
            -- },

            -- additional_paths = "backend.ripgrep.additional_paths",
            -- additional_rg_options = "backend.ripgrep.additional_rg_options",
            -- context_size = "backend.context_size",
            -- ignore_paths = "backend.ripgrep.ignore_paths",
            -- max_filesize = "backend.ripgrep.max_filesize",
            -- project_root_fallback = "backend.ripgrep.project_root_fallback",
            -- search_casing = "backend.ripgrep.search_casing"

            ripgrep = {
                max_items = 500,
                module = 'blink-ripgrep',
                name = 'Ripgrep',
                score_offset = -3,
                async = true,
                opts = {
                    -- the minimum length of the current word to start searching
                    prefix_min_len = 3,

                    -- Specifies how to find the root of the project where the ripgrep search will start from.
                    project_root_marker = '.git',

                    -- When a result is found for a file whose filetype does not have a treesitter parser installed, fall back to regex based highlighting that is bundled in Neovim.
                    fallback_to_regex_highlighting = true,
                    debug = false,

                    backend = {
                        use = 'ripgrep',
                        -- Whether to set up custom highlight-groups for the icons used
                        -- in the completion items. Defaults to `true`, which means this
                        -- is enabled.
                        customize_icon_highlight = true,

                        ripgrep = {

                            -- The number of lines to show around each match in the preview (documentation) window. Before and after
                            context_size = 5,

                            -- The maximum file size of a file that ripgrep should include in its search.
                            max_filesize = '1M',

                            -- Enable fallback to neovim cwd if project_root_marker is not found. Default: `true`, which means to use the cwd.
                            project_root_fallback = true,

                            -- The casing to use for the search in a format that ripgrep accepts. Defaults to "--ignore-case".
                            search_casing = '--ignore-case',

                            -- (advanced) Any additional options you want to give to ripgrep.
                            additional_rg_options = {},

                            -- Absolute root paths where the rg command will not be executed.
                            ignore_paths = { 'dict/' },

                            -- Any additional paths to search in, in addition to the project root.
                            additional_paths = {},
                        },
                    },
                },
                -- (optional) customize how the results are displayed.
                transform_items = function(ctx, items)
                    local kind = require('blink.cmp.types').CompletionItemKind.File

                    local icon = require('icons').misc.search

                    for i = 1, #items do
                        -- items[i].kind = kind
                        items[i].kind_icon = icon
                        items[i].kind_name = 'Ripgrep'
                    end

                    return items
                end,
            },
            -- nerdfont = {
            --     name = 'Nerd Fonts',
            --     module = 'blink-nerdfont',
            --     score_offset = 0,
            --     async = true,
            --     -- name = 'nerdfont',
            --     -- module = 'blink.compat.source',
            --
            --     transform_items = function(ctx, items)
            --         -- check https://github.com/Saghen/blink.cmp/pull/253#issuecomment-2454984622
            --         local kind = require('blink.cmp.types').CompletionItemKind.Color
            --
            --         local icon = require('icons').misc.glasses
            --
            --         for i = 1, #items do
            --             -- items[i].kind = kind
            --             items[i].kind_icon = icon
            --             items[i].kind_name = 'Nerd Fonts'
            --         end
            --
            --         return items
            --     end,
            -- },
            -- emoji = {
            --     module = 'blink-emoji',
            --     name = 'Emoji',
            --     score_offset = 0,
            --     async = true,
            --
            --     transform_items = function(ctx, items)
            --         local kind = require('blink.cmp.types').CompletionItemKind.Color
            --
            --         local icon = require('icons').misc.emoji
            --
            --         for i = 1, #items do
            --             -- items[i].kind = kind
            --             items[i].kind_icon = icon
            --             items[i].kind_name = 'Emoji'
            --         end
            --
            --         return items
            --     end,
            --
            --     opts = { insert = true },
            -- },
        },
    },

    appearance = {
        use_nvim_cmp_as_default = false,
        nerd_font_variant = 'mono',
        kind_icons = require('icons').symbol_kinds,
    },
})

vim.lsp.config('*', { capabilities = require('blink.cmp').get_lsp_capabilities(nil, true) })
