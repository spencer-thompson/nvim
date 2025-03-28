local icons = require('icons').diagnostics

-- Diagnostic configuration.
vim.diagnostic.config({

    -- vim.diagnostic.config({
    --     virtual_lines = true,
    --     virtual_text = false,
    -- })
    virtual_text = false,
    -- virtual_text = {
    --     prefix = '',
    --     spacing = 2,
    --     format = function(diagnostic)
    --         -- Use shorter, nicer names for some sources:
    --         local special_sources = {
    --             ['Lua Diagnostics.'] = 'lua',
    --             ['Lua Syntax Check.'] = 'lua',
    --         }
    --
    --         local message = diagnostic_icons[vim.diagnostic.severity[diagnostic.severity]]
    --         if diagnostic.source then
    --             message = string.format('%s %s', message, special_sources[diagnostic.source] or diagnostic.source)
    --         end
    --         if diagnostic.code then
    --             message = string.format('%s[%s]', message, diagnostic.code)
    --         end
    --
    --         return message .. ' '
    --     end,
    -- },
    virtual_lines = {
        current_line = true,

        -- prefix = function(diag)
        --     local level = vim.diagnostic.severity[diag.severity]
        --     local prefix = string.format(' %s ', icons[level])
        --     return prefix, 'Diagnostic' .. level:gsub('^%l', string.upper)
        -- end,
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
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = icons.ERROR,
            [vim.diagnostic.severity.WARN] = icons.WARN,
            [vim.diagnostic.severity.INFO] = icons.INFO,
            [vim.diagnostic.severity.HINT] = icons.HINT,
        },
    },
})
