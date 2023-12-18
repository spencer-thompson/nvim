return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',

        -- status updates for lsp
        { 'j-hui/fidget.nvim', opts = {} },

        'folke/neodev.nvim',
        'simrat39/inlay-hints.nvim',
    },
    config = function()
        require('mason').setup()
        require('mason-lspconfig').setup()

        require('neodev').setup()

        local servers = {
            -- stuff #todo
            clangd = {},
            gopls = {},
            pyright = {
                Python = {},
            },
            html = { filetypes = { 'html', 'twig', 'hbs'} },

            lua_ls = {
                Lua = {
                    workspace = { checkThirdParty = false },
                    telemetry = { enable = false },
                    -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                    -- diagnostics = { disable = { 'missing-fields' } },
                },
            },
        }
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
        local mason_lspconfig = require 'mason-lspconfig'
        mason_lspconfig.setup { ensure_installed = vim.tbl_keys(servers) }
        mason_lspconfig.setup_handlers {
            function(server_name)
                require('lspconfig')[server_name].setup {
                    capabilities = capabilities,
                    on_attach = on_attach,
                    settings = servers[server_name],
                    filetypes = (servers[server_name] or {}).filetypes,
                }
            end,
        }
    end,
}
