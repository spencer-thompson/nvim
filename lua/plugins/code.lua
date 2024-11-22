return {

    {
        'saghen/blink.cmp',
        lazy = true, -- lazy loading handled internally
        event = { 'VeryLazy', 'InsertEnter' },
        -- optional: provides snippets for the snippet source
        dependencies = {
            'rafamadriz/friendly-snippets',
            'saghen/blink.compat',
            { 'chrisgrieser/cmp-nerdfont', lazy = true },
            { 'hrsh7th/cmp-emoji', lazy = true },
        },

        -- use a release tag to download pre-built binaries
        version = 'v0.*',
        -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
        -- build = 'cargo build --release',
        -- If you use nix, you can build from source using latest nightly rust with:
        -- build = 'nix run .#build-plugin',

        opts = {
            -- 'default' for mappings similar to built-in completion
            -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
            -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
            -- see the "default configuration" section below for full documentation on how to define
            -- your own keymap.
            -- keymap = { preset = 'default' },
            keymap = {
                preset = 'default',
                ['<C-h>'] = { 'show', 'show_documentation', 'hide_documentation' },
                -- ['<C-h>'] = { 'show' },
                ['<C-k>'] = { 'select_prev', 'fallback' },
                ['<C-j>'] = { 'select_next', 'fallback' },
                -- ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
                -- ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
            },

            sources = {
                completion = {
                    enabled_providers = { 'lsp', 'path', 'snippets', 'buffer', 'lazydev', 'nerdfont', 'emoji' },
                },
                providers = {
                    lsp = { fallback_for = { 'lazydev' } },
                    lazydev = { name = 'LazyDev', module = 'lazydev.integrations.blink' },
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
                    emoji = {
                        name = 'emoji',
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

            highlight = {
                -- sets the fallback highlight groups to nvim-cmp's highlight groups
                -- useful for when your theme doesn't support blink.cmp
                -- will be removed in a future release, assuming themes add support
                use_nvim_cmp_as_default = true,
            },
            -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
            -- adjusts spacing to ensure icons are aligned
            nerd_font_variant = 'mono',

            windows = {
                autocomplete = {
                    -- draw = "reversed",
                    winblend = vim.o.pumblend,
                },
                documentation = {
                    auto_show = true,
                },
                ghost_text = {
                    enabled = true,
                },
            },

            -- experimental auto-brackets support
            accept = { auto_brackets = { enabled = true } },

            -- experimental signature help support
            -- trigger = { signature_help = { enabled = true } },
        },
    },

    {
        'hrsh7th/nvim-cmp',
        -- lazy = false,
        -- priority = 100,
        version = false,
        enabled = false,
        event = 'InsertEnter',
        dependencies = {
            { 'onsails/lspkind-nvim', name = 'lspkind' },
            { 'L3MON4D3/LuaSnip', name = 'luasnip' },
            { 'hrsh7th/cmp-buffer' },
            { 'rafamadriz/friendly-snippets', name = 'friendly-snippets' },
            { 'saadparwaiz1/cmp_luasnip', name = 'cmp-luasnip' },
            { 'hrsh7th/cmp-cmdline' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },
            { 'hrsh7th/cmp-path' },
            { 'f3fora/cmp-spell' },
            { 'garyhurtz/cmp_kitty', name = 'cmp-kitty' },
            { 'hrsh7th/cmp-emoji' },
            { 'chrisgrieser/cmp-nerdfont' },
            -- { 'kdheepak/cmp-latex-symbols' }, -- slow
            { 'kristijanhusak/vim-dadbod-completion', name = 'dadbod-completions', enabled = false },
            -- {
            --     'MattiasMTS/cmp-dbee',
            --     ft = 'sql', -- optional but good to have
            --     opts = {}, -- needed
            -- },
            {
                'brenoprata10/nvim-highlight-colors',
                name = 'highlight-colors',
                config = function()
                    require('nvim-highlight-colors').setup({

                        render = 'virtual',
                        ---Set virtual symbol (requires render to be set to 'virtual')
                        virtual_symbol = ' ',

                        ---Set virtual symbol suffix (defaults to '')
                        virtual_symbol_prefix = '',

                        ---Set virtual symbol suffix (defaults to ' ')
                        virtual_symbol_suffix = '',

                        ---Set virtual symbol position()
                        ---@usage 'inline'|'eol'|'eow'
                        ---inline mimics VS Code style
                        ---eol stands for `end of column` - Recommended to set `virtual_symbol_suffix = ''` when used.
                        ---eow stands for `end of word` - Recommended to set `virtual_symbol_prefix = ' ' and virtual_symbol_suffix = ''` when used.
                        virtual_symbol_position = 'inline',

                        ---Highlight hex colors, e.g. '#FFFFFF'
                        enable_hex = true,

                        ---Highlight short hex colors e.g. '#fff'
                        enable_short_hex = true,

                        ---Highlight rgb colors, e.g. 'rgb(0 0 0)'
                        enable_rgb = true,

                        ---Highlight hsl colors, e.g. 'hsl(150deg 30% 40%)'
                        enable_hsl = true,

                        ---Highlight CSS variables, e.g. 'var(--testing-color)'
                        enable_var_usage = true,

                        ---Highlight named colors, e.g. 'green'
                        enable_named_colors = true,

                        ---Highlight tailwind colors, e.g. 'bg-blue-500'
                        enable_tailwind = false,

                        ---Set custom colors
                        ---Label must be properly escaped with '%' to adhere to `string.gmatch`
                        --- :help string.gmatch
                        -- custom_colors = {
                        --     { label = '%-%-theme%-primary%-color', color = '#0f1219' },
                        --     { label = '%-%-theme%-secondary%-color', color = '#5a5d64' },
                        -- },

                        -- Exclude filetypes or buftypes from highlighting e.g. 'exclude_buftypes = {'text'}'
                        exclude_filetypes = {},
                        exclude_buftypes = {},
                    })
                end,
            },
        },
    },

    {
        'rachartier/tiny-inline-diagnostic.nvim',
        name = 'tiny-inline-diagnostic',
        event = 'LspAttach', -- Or `LspAttach`
        config = function()
            require('tiny-inline-diagnostic').setup({
                hi = {
                    background = 'None',
                },
            })
        end,
    },

    {
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

    {
        'mfussenegger/nvim-dap',
        name = 'dap',
        -- event = "VeryLazy",
        lazy = true,
    },

    {
        'mbbill/undotree',
        name = 'undotree',
        event = 'VeryLazy',
        config = function()
            vim.keymap.set('n', '<leader>ut', vim.cmd.UndotreeToggle, { desc = '[U]ndo[t]ree' })
        end,
    },

    { 'tpope/vim-sleuth', event = 'VeryLazy' }, -- auto adjust shift and tabs
}
