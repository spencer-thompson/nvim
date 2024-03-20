local colors = require('tokyonight.colors').setup({ transform = true })
-- get current color scheme colors

local empty = require('lualine.component'):extend()
function empty:draw(default_highlight)
    self.status = ''
    self.applied_separator = ''
    self:apply_highlights(default_highlight)
    self:apply_section_separators()
    return self.status
end

-- Put proper separators and gaps between components in sections
local function process_sections(sections)
    for name, section in pairs(sections) do
        local left = name:sub(9, 10) < 'x'
        for pos = 1, name ~= 'lualine_z' and #section or #section - 1 do
            table.insert(section, pos * 2, { empty, color = { fg = colors.bg, bg = colors.bg } })
        end
        for id, comp in ipairs(section) do
            if type(comp) ~= 'table' then
                comp = { comp }
                section[id] = comp
            end
            comp.separator = left and { right = '' } or { left = '' }
        end
    end
    return sections
end

require('lualine').setup({
    options = {
        icons_enabled = true,
        -- theme = 'molokai',
        theme = 'auto',
        component_separators = { left = '│', right = '│' }, -- │
        -- component_separators = { left = '', right = '' },
        -- { left = '', right = '' }, { left = '', right = '' }, '|'
        -- section_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
            statusline = { 'dashboard' },
            winbar = { 'dashboard', 'neo-tree' },
            tabline = { 'dashboard', 'neo-tree', 'nerdtree' },
        },
        ignore_focus = {},
        always_divide_middle = false,
        globalstatus = true,
        refresh = {
            statusline = 100,
            tabline = 1000,
            winbar = 1000,
        },
    },

    -- tabline = process_sections({
    tabline = {
        lualine_a = {
            -- { 'fileformat', padding = { left = 1, right = 1 } },
            -- { "filetype", icon = { align = "left" } },
            {
                'buffers',
                hide_filename_extension = true,
                separator = '', -- separator = { left = '', right = '' },
                filetype_names = {
                    TelescopePrompt = 'Telescope',
                    dashboard = 'Dashboard',
                    fzf = 'FZF',
                    alpha = 'Alpha',
                    lazy = 'Lazy',
                    nerdtree = 'File Tree',
                    -- neotree = 'NeoTree',
                },
                use_mode_colors = true,
                -- buffers_color = {
                --     active = 'lualine_a_active',
                --     inactive = 'lualine_b_inactive',
                -- },
                -- separator = '',
                -- use_mode_colors = true,
                symbols = {
                    modified = ' ● ', -- text to show when the buffer is modified
                    alternate_file = '# ', -- text to show to identify the alternate file
                    directory = '  ', -- text to show when the buffer is a directory
                },
            },
            -- {
            --     'filename',
            --     path = 1,
            --     -- symbols = {
            --     --     modified = ' ', -- Text to show when the file is modified.
            --     --     readonly = ' ', -- Text to show when the file is non-modifiable or readonly.
            --     --     unnamed = ' ', -- Text to show for unnamed buffers.
            --     --     newfile = ' ', -- Text to show for newly created file before first write
            --     -- }
            -- }
        },
        lualine_b = {
            -- {
            --     'buffers',
            --     hide_filename_extension = true,
            --     -- separator = { left = '', right = '' },
            --     -- separator = '  ',
            --     -- 
            --     filetype_names = {
            --         TelescopePrompt = 'Telescope',
            --         dashboard = 'Dashboard',
            --         -- packer = 'Packer',
            --         fzf = 'FZF',
            --         alpha = 'Alpha',
            --         lazy = 'Lazy',
            --     },
            --     -- buffers_color = {
            --     --     active = 'BufferActive',
            --     --     inactive = 'BufferInactive',
            --     -- },
            --     -- separator = '',
            --     -- use_mode_colors = true,
            --     symbols = {
            --         modified = ' ● ', -- text to show when the buffer is modified
            --         alternate_file = '# ', -- text to show to identify the alternate file
            --         directory = '  ', -- text to show when the buffer is a directory
            --     },
            -- },
            -- { function() return '' end, draw_empty = true },
        },
        lualine_c = {},
        lualine_x = {
            -- {
            --     require("lazy.status").updates,
            --     cond = require("lazy.status").has_updates,
            -- },
        },
        lualine_y = {
            { 'encoding', padding = { left = 1, right = 1 } },
        },
        lualine_z = {
            {
                'tabs',
                mode = 1,
                path = 0,
                use_mode_colors = true,
            },
            -- {
            --     function()
            --         return 'NEOVIM'
            --     end,
            --     colored = false,
            --     icon_only = true,
            -- }
        },
    },

    --[[ BAR FOR EACH WINDOW ]]

    winbar = {
        lualine_a = {},
        lualine_b = {

            -- {
            --     'filename',
            --     file_status = true,
            --     symbols = {
            --         modified = '[+]',      -- Text to show when the file is modified.
            --         readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
            --         unnamed = '[No Name]', -- Text to show for unnamed buffers.
            --         newfile = '[New]',     -- Text to show for newly created file before first write
            --     }
            -- },
            -- {
            --     'windows',
            --     show_filename_only = true,
            --     hide_filename_extension = true,
            --     show_modified_status = true,
            --     mode = 0,
            --     filetype_names = {
            --         TelescopePrompt = 'Telescope',
            --         dashboard = 'Dashboard',
            --         -- packer = 'Packer',
            --         fzf = 'FZF',
            --         alpha = 'Alpha'
            --     },
            --
            -- },
        },
        lualine_c = {
            -- {
            --     'diagnostics',
            --     sources = { 'nvim_diagnostic', 'nvim_lsp' },
            --     sections = { 'error', 'warn', 'info', 'hint' },
            --     diagnostics_color = {          -- Same values as the general color option can be used here.
            --         error = 'DiagnosticError', -- Changes diagnostics' error color.
            --         warn  = 'DiagnosticWarn',  -- Changes diagnostics' warn color.
            --         info  = 'DiagnosticInfo',  -- Changes diagnostics' info color.
            --         hint  = 'DiagnosticHint',  -- Changes diagnostics' hint color.
            --     },
            --     colored = true,
            -- },
        },
        lualine_x = {
            -- { 'progress' },
            -- { --[[ function() return '[%L]' end ]] },
            -- { "filesize", padding = { left = 1, right = 1 } },
            -- {
            --     'filetype',
            --     fmt = string.upper,
            --     colored = false,
            --     icon = { align = 'right' },
            -- },
        },
        lualine_y = {},
        lualine_z = {},
    },

    --[[ BAR FOR INACTIVE WINDOWS ]]

    inactive_winbar = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
            -- 'filename',
        },
        lualine_x = {
            -- function() return '[%L]' end,
            -- {
            --     'filetype',
            --     fmt = string.lower,
            --     colored = false,
            --     icon = { align = 'right' },
            -- }
        },
        lualine_y = {},
        lualine_z = {},
    },

    sections = {
        lualine_a = {
            {
                'mode',
                -- separator = { left = '' },
                padding = { right = 1, left = 1 },
            },
            {
                'macro-recording',
                fmt = function()
                    local recording_register = vim.fn.reg_recording()
                    if recording_register == '' then
                        return ''
                    else
                        return 'Recording @' .. recording_register
                    end
                end,
            },
        },
        lualine_b = {
            {
                'branch',
                padding = { right = 1, left = 1 },
            },
        },
        lualine_c = {
            {
                'diff',
                symbols = {
                    added = '+ ',
                    modified = '~ ',
                    removed = '- ',
                },
                padding = { right = 1, left = 1 },
                source = function()
                    local gitsigns = vim.b.gitsigns_status_dict
                    if gitsigns then
                        return {
                            added = gitsigns.added,
                            modified = gitsigns.changed,
                            removed = gitsigns.removed,
                        }
                    end
                end,
            },
            {
                'diagnostics',
                sources = { 'nvim_diagnostic', 'nvim_lsp' },
                sections = { 'error', 'warn', 'info', 'hint' },
                symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' }, --    
                colored = true,
                update_in_insert = true,
            },
            -- { function() return '' end, draw_empty = true },
            -- {
            --     'filename',
            --     path = 3,
            --
            --     symbols = {
            --         modified = ' ● ', -- text to show when the buffer is modified
            --         alternate_file = ' # ', -- text to show to identify the alternate file
            --         directory = '  ', -- text to show when the buffer is a directory
            --     },
            -- },
            -- { function() return '' end, draw_empty = true },
            -- {
            --     'buffers',
            --     hide_filename_extension = true,
            --     filetype_names = {
            --         telescopeprompt = 'telescope',
            --         dashboard = 'dashboard',
            --         packer = 'packer',
            --         fzf = 'fzf',
            --         alpha = 'alpha'
            --     },
            --     symbols = {
            --         modified = ' ●', -- text to show when the buffer is modified
            --         alternate_file = '#', -- text to show to identify the alternate file
            --         directory = '', -- text to show when the buffer is a directory
            --     },
            -- },
        },
        lualine_x = {
            -- {
            --     function()
            --         local pressed = require("noice").api.status.command.get()
            --         if pressed == '<20>' then
            --             pressed = '<leader>'
            --         end
            --         return pressed
            --     end,
            --     cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
            -- },
            {
                function()
                    if vim.v.hlsearch == 0 then
                        return ''
                    end
                    local last_search = vim.fn.getreg('/')
                    if not last_search or last_search == '' then
                        return ''
                    end
                    local searchcount = vim.fn.searchcount({ maxcount = 9999 })
                    return '"' .. last_search .. '" : ' .. '[' .. searchcount.current .. '/' .. searchcount.total .. ']'
                end,
            },
            -- {
            --     function() return require("noice").api.status.mode.get() end,
            --     cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
            -- },
        },
        lualine_y = {
            {
                require('lazy.status').updates,
                cond = require('lazy.status').has_updates,
            },
        },
        lualine_z = {
            {
                'datetime',
                style = 'default',
                -- separator = { left = '' },
                padding = { left = 1, right = 1 },
            },
        },
    },
    -- inactive_sections = {
    --     lualine_a = {},
    --     lualine_b = {},
    --     lualine_c = { 'filename' },
    --     lualine_x = { 'location' },
    --     lualine_y = {},
    --     lualine_z = {}
    -- },

    extensions = { 'neo-tree', 'lazy', 'fzf', 'fugitive', 'mason', 'trouble', 'toggleterm', 'man' },
})
