-- set icons and fancy number highlight
vim.cmd([[sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=DiagnosticSignError]])
vim.cmd([[sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=DiagnosticSignWarn]])
vim.cmd([[sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=DiagnosticSignInfo]])
vim.cmd([[sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=DiagnosticSignHint ]])

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

local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

local default_setup = function(server)
    require('lspconfig')[server].setup({
        capabilities = lsp_capabilities,
    })
end

local lspconfig = require('lspconfig')

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
        --     require('lspconfig').basedpyright.setup({
        --         capabilities = lsp_capabilities,
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
        awk_ls = function()
            require('lspconfig').awk_ls.setup({
                capabilities = lsp_capabilities,
                cmd = { 'awk-language-server' },
                filetypes = { 'awk' },
            })
        end,
        bashls = function()
            require('lspconfig').bashls.setup({
                capabilities = lsp_capabilities,
                cmd = { 'bash-language-server', 'start' },
                filetypes = { 'sh' },
            })
        end,
        gopls = function()
            require('lspconfig').gopls.setup({
                capabilities = lsp_capabilities,
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
            require('lspconfig').lua_ls.setup({
                capabilities = lsp_capabilities,
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
                capabilities = lsp_capabilities,
                settings = {
                    pyright = {
                        autoImportCompletion = true,
                    },
                    python = {
                        analysis = {
                            autoSearchPaths = true,
                            diagnosticMode = 'openFilesOnly',
                            useLibraryCodeForTypes = true,
                            typeCheckingMode = 'off',
                        },
                    },
                },
            })
        end,
        -- r = function()
        --     require('lspconfig').r_language_server.setup({
        --
        --         capabilities = lsp_capabilities,
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

vim.diagnostic.config({ virtual_text = false })

-- return {
--     {
--         'neovim/nvim-lspconfig',
--         name = 'lspconfig',
--         cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
--         event = { 'BufReadPre', 'BufNewFile' },
--         dependencies = {
--             { 'williamboman/mason.nvim', name = 'mason' },
--             { 'williamboman/mason-lspconfig.nvim', name = 'mason-lspconfig' },
--             { 'WhoIsSethDaniel/mason-tool-installer.nvim', name = 'mason-installer' },
--         },
--         config = function()
--             local capabilities = nil
--             if pcall(require, 'cmp_nvim_lsp') then
--                 capabilities = require('cmp_nvim_lsp').default_capabilities()
--             end
--
--             local lspconfig = require('lspconfig')
--         end,
--         -- opts = {
--         --     diagnostics = {
--         --         underline = true,
--         --         update_in_insert = false,
--         --         severity_sort = true,
--         --     },
--         --     document_highlight = {
--         --         enabled = true,
--         --     },
--         -- },
--     },
-- }
