return {
    {
        'neovim/nvim-lspconfig',
        name = 'lspconfig',
        -- cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
        -- event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            { 'williamboman/mason.nvim', name = 'mason' },
            { 'williamboman/mason-lspconfig.nvim', name = 'mason-lspconfig' },
            { 'WhoIsSethDaniel/mason-tool-installer.nvim', name = 'mason-installer' },
        },
        config = function()
            local capabilities = nil
            if pcall(require, 'cmp_nvim_lsp') then
                capabilities = require('cmp_nvim_lsp').default_capabilities()
            end

            local lspconfig = require('lspconfig')

            local default_setup = function(server)
                lspconfig[server].setup({
                    capabilities = capabilities,
                })
            end

            require('mason').setup({})
            require('mason-tool-installer').setup({
                ensure_installed = {
                    'black',
                    'lua_ls',
                    'ruff',
                    'stylua',
                    'vale',
                },
            })
            require('mason-lspconfig').setup({
                -- ensure_installed = {
                --     'gopls',
                --     'lua_ls',
                -- },
                handlers = {
                    default_setup,

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

                    arduino_language_server = function()
                        lspconfig.arduino_language_server.setup({
                            capabilities = capabilities,
                        })
                    end,
                    awk_ls = function()
                        lspconfig.awk_ls.setup({
                            capabilities = capabilities,
                            cmd = { 'awk-language-server' },
                            filetypes = { 'awk' },
                        })
                    end,
                    bashls = function()
                        lspconfig.bashls.setup({
                            capabilities = capabilities,
                            cmd = { 'bash-language-server', 'start' },
                            filetypes = { 'sh' },
                        })
                    end,
                    gopls = function()
                        lspconfig.gopls.setup({
                            capabilities = capabilities,
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
                        })
                    end,
                    lua_ls = function()
                        lspconfig.lua_ls.setup({
                            capabilities = capabilities,
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
                        })
                    end,
                    pyright = function()
                        lspconfig.pyright.setup({
                            capabilities = capabilities,
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
                        })
                    end,
                    ruff = function()
                        lspconfig.ruff.setup({
                            capabilities = capabilities,
                        })
                    end,
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
                    local opts = { buffer = event.buf }

                    -- these will be buffer-local keybindings
                    -- because they only work if you have an active language server
                    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
                    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
                    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
                    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
                    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
                    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
                    -- vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
                    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts) -- todo change
                    -- vim.keymap.set({ 'n', 'x' }, '<leader><leader>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
                    vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
                    vim.keymap.set(
                        'n',
                        '<leader>i',
                        '<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>',
                        { desc = 'Toggle Inlay Hints' }
                    )
                end,
            })

            vim.diagnostic.config({ virtual_text = false })
            -- vim.keymap.set()
        end,
    },
}
