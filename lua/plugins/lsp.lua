return {
    {
        'neovim/nvim-lspconfig',
        name = 'lspconfig',
        -- cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
        event = { 'BufReadPre', 'BufNewFile', 'VeryLazy' },
        dependencies = {
            { 'saghen/blink.cmp' },
            { 'williamboman/mason.nvim', name = 'mason' },
            { 'williamboman/mason-lspconfig.nvim', name = 'mason-lspconfig' },
            { 'WhoIsSethDaniel/mason-tool-installer.nvim', name = 'mason-installer' },
        },
        opts = {},
        config = function()
            local servers = {
                -- basedpyright = function()
                --     lspconfig.basedpyright.setup({
                --         capabilities = capabilities,
                -- filetypes = { 'py' },
                -- settings = {
                --     basedpyright = {
                --         analysis = {
                --             -- autoImportCompletions = true,
                --             autoSearchPaths = true,
                --             -- useLibraryCodeForTypes = true,
                --             diagnosticMode = 'openFilesOnly',
                --         },
                --     },
                -- },
                --     })
                -- end,

                arduino_language_server = {},
                awk_ls = {
                    cmd = { 'awk-language-server' },
                    filetypes = { 'awk' },
                },
                bashls = {
                    cmd = { 'bash-language-server', 'start' },
                    filetypes = { 'sh' },
                },
                clangd = {
                    filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'arduino' },
                },
                -- eslint = function()
                --     lspconfig.eslint.setup({
                --         settings = {
                --             packageManager = 'yarn',
                --         },
                --         on_attach = function(client, bufnr)
                --             vim.api.nvim_create_autocmd('BufWritePre', {
                --                 buffer = bufnr,
                --                 command = 'EslintFixAll',
                --             })
                --         end,
                --     })
                -- end,
                -- dartls = function()
                --     lspconfig.dartls.setup({
                --         capabilities = capabilities,
                --     })
                -- end,
                gopls = {
                    cmd = { 'gopls' },
                    filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
                    -- root_dir = util.root_pattern('go.work', 'go.mod', '.git'),
                    settings = {
                        gopls = {
                            hints = {
                                assignVariableTypes = true,
                                compositeLiteralFields = true,
                                compositeLiteralTypes = true,
                                constantValues = true,
                                functionTypeParameters = true,
                                parameterNames = true,
                                rangeVariableTypes = true,
                            },
                            analyses = {
                                unusedparams = true,
                                shadow = true,
                            },
                            completeUnimported = true,
                            gofumpt = true,
                            usePlaceholders = true,
                        },
                    },
                },
                lua_ls = {
                    settings = {
                        Lua = {
                            format = {
                                enable = true,
                                defaultConfig = {
                                    indent_style = 'space',
                                    indent_size = '4',
                                },
                            },
                            runtime = {
                                version = 'LuaJIT',
                            },
                            diagnostics = {
                                globals = { 'vim' },
                                disable = { 'missing-fields' },
                            },
                            workspace = {
                                checkThirdParty = false,
                                libary = {
                                    vim.env.VIMRUNTIME,
                                },
                            },
                            telemetry = {
                                enable = false,
                            },
                            hint = { enable = true },
                        },
                    },
                },
                pyright = {
                    settings = {
                        pyright = {
                            autoImportCompletion = true,
                            disableOrganizeImports = true, -- Using Ruff
                        },
                        python = {
                            analysis = {
                                ignore = { '*' }, -- Using Ruff
                                autoSearchPaths = true,
                                diagnosticMode = 'openFilesOnly',
                                useLibraryCodeForTypes = true,
                                typeCheckingMode = 'off', -- try basic eventually
                            },
                        },
                    },
                },
                ruff = {},
                typst_lsp = {
                    on_init = function(client, _)
                        client.server_capabilities.semanticTokensProvider = nil -- turn off semantic tokens
                    end,
                },
                -- rust?
                -- r = function()
                --     lspconfig.r_language_server.setup({
                --
                --         capabilities = capabilities,
                --         settings = {
                --             r = {
                --                 lsp = {
                --                     formatting_style = {
                --                         tabSize = 2,
                --                         insertSpaces = true,
                --                     },
                --                 },
                --             },
                --         },
                --     })
                -- end,
            }

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            -- capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

            local lspconfig = require('lspconfig')

            -- if capabilities ~= nil then
            --     capabilities.workspace.semanticTokens.refreshSupport = false
            -- end

            -- local default_setup = function(server)
            --     lspconfig[server].setup({
            --         capabilities = capabilities,
            --     })
            -- end

            require('mason').setup({})
            local ensure_installed = vim.tbl_keys(servers or {})
            vim.list_extend(ensure_installed, {
                'stylua', -- Used to format Lua code
            })
            require('mason-tool-installer').setup({
                ensure_installed = ensure_installed,
            })
            require('mason-lspconfig').setup({
                handlers = {
                    function(server_name)
                        local server = servers[server_name] or {}

                        capabilities = vim.tbl_deep_extend(
                            'force',
                            capabilities,
                            require('blink.cmp').get_lsp_capabilities(server.capabilities)
                        )
                        server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
                        lspconfig[server_name].setup(server)
                    end,
                },
            })

            vim.cmd(
                [[sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=DiagnosticSignError]]
            )
            vim.cmd(
                [[sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=DiagnosticSignWarn]]
            )
            vim.cmd(
                [[sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=DiagnosticSignInfo]]
            )
            vim.cmd(
                [[sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=DiagnosticSignHint ]]
            )

            vim.api.nvim_create_autocmd('LspAttach', {
                desc = 'LSP actions',
                callback = function(event)
                    -- these will be buffer-local keybindings
                    -- because they only work if you have an active language server
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Show Hover Docs', buffer = event.buf })
                    -- vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', { desc = "", buffer = event.buf })
                    vim.keymap.set(
                        'n',
                        'gd',
                        require('telescope.builtin').lsp_definitions,
                        { desc = '[D]efinitions', buffer = event.buf }
                    )
                    vim.keymap.set(
                        'n',
                        'gR',
                        require('telescope.builtin').lsp_references,
                        { desc = '[R]eferences', buffer = event.buf }
                    )
                    vim.keymap.set(
                        'n',
                        'gI',
                        require('telescope.builtin').lsp_implementations,
                        { desc = '[I]mplementations', buffer = event.buf }
                    )
                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = '[D]eclaration', buffer = event.buf })
                    vim.keymap.set(
                        'n',
                        'go',
                        vim.lsp.buf.type_definition,
                        { desc = 'Type Definition', buffer = event.buf }
                    )
                    -- vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', { desc = "", buffer = event.buf })
                    vim.keymap.set('n', 'gr', vim.lsp.buf.rename, { desc = 'LSP [R]ename', buffer = event.buf }) -- todo change
                    -- vim.keymap.set({ 'n', 'x' }, '<leader><leader>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', { desc = "", buffer = event.buf })
                    vim.keymap.set('n', 'gC', vim.lsp.buf.code_action, { desc = '[C]ode Action', buffer = event.buf })
                    vim.keymap.set(
                        'n',
                        '<leader>i',
                        '<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>',
                        { desc = '[I]nlay Hints', buffer = event.buf }
                    )
                end,
            })

            vim.diagnostic.config({ virtual_text = false })
            -- vim.keymap.set()
        end,
    },
}
