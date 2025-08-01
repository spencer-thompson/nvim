local icons = require('icons').diagnostics

for filename in (vim.fs.dir('~/.config/nvim/after/lsp')) do
    vim.lsp.enable(filename:match('(.+)%.lua') or filename)
end

vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', { desc = 'Open Diagnostic Float' })

vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        -- these will be buffer-local keybindings
        -- because they only work if you have an active language server
        vim.keymap.set('n', 'K', function()
            -- local ok, node = pcall(vim.treesitter.get_node)
            -- if
            --     ok
            --     and node
            --     and vim.tbl_contains({ 'text', 'comment', 'block_comment', 'paragraph' }, node:type())
            -- then
            --     -- do stuff
            --     Snacks.win({
            --         text = vim.system({ 'wn', vim.fn.expand('<cword>'), '-over' }, { text = true }):wait(),
            --     })
            -- else
            vim.lsp.buf.hover()
            -- end
        end, { desc = 'Show Hover Docs', buffer = event.buf })

        vim.keymap.set('n', 'gra', function()
            require('tiny-code-action').code_action()
        end, { desc = 'Code Action' })

        vim.keymap.set('n', 'grr', '<cmd>FzfLua lsp_references<cr>', { desc = 'Lsp References' })
        vim.keymap.set('n', 'gd', function()
            require('fzf-lua').lsp_definitions({ jump1 = true })
        end, { desc = '[G]oto [D]efinition' })
        vim.keymap.set('n', 'gD', function()
            require('fzf-lua').lsp_definitions({ jump1 = false })
        end, { desc = 'Peek [D]efinition' })

        -- vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', { desc = "", buffer = event.buf })
        -- vim.keymap.set('n', 'gd', Snacks.picker.lsp_definitions, { desc = '[D]efinitions', buffer = event.buf })
        -- vim.keymap.set('n', 'gR', Snacks.picker.lsp_references, { desc = '[R]eferences', buffer = event.buf })
        -- vim.keymap.set('n', 'gI', Snacks.picker.lsp_implementations, { desc = '[I]mplementations', buffer = event.buf })
        -- vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, { desc = 'Code [A]ction', buffer = event.buf })
        -- vim.keymap.set('n', 'gD', Snacks.picker.lsp_declarations, { desc = '[D]eclaration', buffer = event.buf })
        -- vim.keymap.set('n', 'go', Snacks.picker.lsp_type_definitions, { desc = 'Type Definition', buffer = event.buf })
        vim.keymap.set('i', '<C-l>', function()
            if require('blink.cmp.completion.windows.menu').win:is_open() then
                require('blink.cmp').hide()
            end
            vim.lsp.buf.signature_help()
        end, { desc = 'Signature Help', buffer = event.buf })
        -- vim.keymap.set(
        --     'n',
        --     'gs',
        --     '<cmd>lua vim.lsp.buf.signature_help()<cr>',
        --     { desc = 'Signature Help', buffer = event.buf }
        -- )
        vim.keymap.set('n', '<leader>R', vim.lsp.buf.rename, { desc = 'LSP [R]ename', buffer = event.buf }) -- todo change
        -- vim.keymap.set({ 'n', 'x' }, '<leader><leader>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', { desc = "", buffer = event.buf })
        vim.keymap.set('n', 'gC', vim.lsp.buf.code_action, { desc = '[C]ode Action', buffer = event.buf })
        vim.keymap.set(
            'n',
            '<leader>i',
            '<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>',
            { desc = '[I]nlay Hints', buffer = event.buf }
        )

        -- Diagnostic configuration.
        vim.diagnostic.config({

            virtual_text = {
                severity = {
                    max = vim.diagnostic.severity.WARN,
                },

                prefix = '',
                spacing = 2,
                format = function(diagnostic)
                    -- Use shorter, nicer names for some sources:
                    local special_sources = {
                        ['Lua Diagnostics.'] = 'lua',
                        ['Lua Syntax Check.'] = 'lua',
                    }

                    local message = icons[vim.diagnostic.severity[diagnostic.severity]]
                    if diagnostic.source then
                        message =
                            string.format('%s %s', message, special_sources[diagnostic.source] or diagnostic.source)
                    end
                    if diagnostic.code then
                        message = string.format('%s[%s]', message, diagnostic.code)
                    end

                    return message .. ' '
                end,
            },
            virtual_lines = {
                -- current_line = true,
                severity = {
                    min = vim.diagnostic.severity.ERROR,
                },
            },
            float = {
                border = 'rounded',
                source = 'if_many',
                -- Show severity icons as prefixes.
                prefix = function(diag)
                    local level = vim.diagnostic.severity[diag.severity]
                    local prefix = string.format(' %s ', icons[level])
                    return prefix, 'Diagnostic' .. level:gsub('^%l', string.upper)
                end,
            },
            -- Disable signs in the gutter.
            signs = false,
            -- signs = {
            --     text = {
            --         [vim.diagnostic.severity.ERROR] = icons.ERROR,
            --         [vim.diagnostic.severity.WARN] = icons.WARN,
            --         [vim.diagnostic.severity.INFO] = icons.INFO,
            --         [vim.diagnostic.severity.HINT] = icons.HINT,
            --     },
            -- },
        })
    end,
})
