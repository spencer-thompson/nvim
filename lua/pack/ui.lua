vim.pack.add({
    { src = 'https://github.com/akinsho/bufferline.nvim', version = vim.version.range('*') },
    { src = 'https://github.com/Isrothy/neominimap.nvim' },
    { src = 'https://github.com/folke/which-key.nvim' },
    { src = 'https://github.com/folke/todo-comments.nvim' },
    { src = 'https://github.com/nvim-lualine/lualine.nvim' },
})

-- vim.g.lualine_laststatus = vim.o.laststatus
-- if vim.fn.argc(-1) > 0 then
--     -- set an empty statusline till lualine loads
--     vim.o.statusline = ' '
-- else
--     -- hide the statusline on the starter page
--     vim.o.laststatus = 0
-- end

require('bufferline').setup({
    options = {

        -- themable = true,
        show_close_icon = false,
        show_buffer_close_icons = false,
        indicator = {
            style = 'underline',
        },
        close_command = function(bufnr)
            MiniBufremove.delete(bufnr, false)
        end,
        diagnostics = 'nvim_lsp',
        always_show_bufferline = true,
        -- auto_toggle_bufferline = true,
        -- separator_style = 'thin',
        separator_style = { '', '' },
        offsets = {
            {
                filetype = 'neo-tree',
                text = 'Neo-tree',
                highlight = 'Directory',
                text_align = 'left',
            },
        },
    },
    highlights = {
        -- background = {
        --     -- fg = 'none',
        --     bg = {
        --         attribute = 'bg',
        --         highlight = 'Pmenu',
        --     },
        -- },
        fill = {
            -- fg = {
            --     attribute = 'bg',
            --     highlight = 'Normal',
            -- },
            -- bg = {
            --     attribute = 'bg',
            --     highlight = 'Pmenu',
            -- },
        },
    },
})

vim.keymap.set('n', '<leader>bp', '<Cmd>BufferLineTogglePin<CR>', { desc = 'Toggle Pin' })
vim.keymap.set('n', '<leader>bP', '<Cmd>BufferLineGroupClose ungrouped<CR>', { desc = 'Delete Non-Pinned Buffers' })
vim.keymap.set('n', '<leader>bo', '<Cmd>BufferLineCloseOthers<CR>', { desc = 'Delete Other Buffers' })
vim.keymap.set('n', '<leader>br', '<Cmd>BufferLineCloseRight<CR>', { desc = 'Delete Buffers to the Right' })
vim.keymap.set('n', '<leader>bl', '<Cmd>BufferLineCloseLeft<CR>', { desc = 'Delete Buffers to the Left' })
vim.keymap.set('n', '<S-h>', '<cmd>BufferLineCyclePrev<cr>', { desc = 'Prev Buffer' })
vim.keymap.set('n', '<S-l>', '<cmd>BufferLineCycleNext<cr>', { desc = 'Next Buffer' })
vim.keymap.set('n', '[b', '<cmd>BufferLineCyclePrev<cr>', { desc = 'Prev Buffer' })
vim.keymap.set('n', ']b', '<cmd>BufferLineCycleNext<cr>', { desc = 'Next Buffer' })
vim.keymap.set('n', '[B', '<cmd>BufferLineMovePrev<cr>', { desc = 'Move buffer prev' })
vim.keymap.set('n', ']B', '<cmd>BufferLineMoveNext<cr>', { desc = 'Move buffer next' })

-- vim.api.nvim_create_autocmd({ 'CmdlineEnter', 'CmdlineLeave' }, {
--     group = vim.api.nvim_create_augroup('ui2_neominimap', {}),
--     callback = function(args)
--         if args.event == 'CmdlineEnter' then
--             -- require('neominimap.api').toggle()
--             vim.g.neominimap.float.margin.bottom = 1
--             -- require('neominimap.api').toggle()
--             require('neominimap.api').refresh()
--         else
--             vim.g.neominimap.float.margin.bottom = 1
--             require('neominimap.api').refresh()
--         end
--     end,
-- })

vim.api.nvim_create_autocmd('WinEnter', {
    group = vim.api.nvim_create_augroup('minimap', { clear = true }),
    pattern = '*',
    callback = function()
        require('neominimap.api').refresh()
    end,
})

vim.g.neominimap = {
    auto_enable = true,
    notification_level = vim.log.levels.OFF,
    layout = 'float',
    delay = 10,
    float = {
        window_border = 'none',
        minimap_width = 18,
        z_index = 1,
        margin = {
            top = -1,
            bottom = -1,
        },
    },
    split = {
        minimap_width = 20,
        fix_width = true,
        direction = 'right',
        close_if_last_window = true,
    },
    click = {
        enabled = false, -- Enable mouse click on minimap
        auto_switch_focus = false, -- Automatically switch focus to minimap when clicked
    },
    current_line_position = 'percent',
    win_filter = function(winid)
        local current_winid = vim.api.nvim_get_current_win()
        return winid == current_winid and vim.fn.winwidth(winid) > 100
    end,
    exclude_filetypes = {
        'dashboard',
        'help',
        'zsh',
        'kitty-scrollback',
        'bigfile',
    },
    exclude_buftypes = {
        'nofile',
        'nowrite',
        'quickfix',
        'terminal',
        'prompt',
    },
    git = {
        enabled = false,
        -- mode = "line",
    },
    mini_diff = {
        enabled = true,
        mode = 'sign',
    },
    diagnostic = {
        enabled = true,
        severity = vim.diagnostic.severity.WARN,
        mode = 'sign',
        priority = {
            ERROR = 100,
            WARN = 90,
            INFO = 80,
            HINT = 70,
        },
    },
    search = { enabled = true, mode = 'sign', priority = 20 },
    mark = { enabled = true, mode = 'sign', priority = 100 },
    fold = {
        enabled = true,
    },
    -- winopt = function(opt, winid)
    --     -- opt.signcolumn = 'auto:2'
    --     -- opt.winblend = 100
    -- end,
    -- handlers = {
    --     todo_comments_handler,
    -- },
}

vim.keymap.set('n', '<leader>tm', '<cmd>Neominimap toggle<CR>', { desc = '[T]oggle [M]inimap' })

-- WHICH KEY --

local wk = require('which-key')
wk.setup({
    preset = 'modern',
    show_help = false,
    win = {
        border = 'single',
    },
})
wk.add({
    { --B
        { '<leader>b', group = 'buffer' },
    },
    -- { -- D
    --     -- {
    --     --     '<leader>dB',
    --     --     function()
    --     --         require('dbee').toggle()
    --     --         -- if not require('dbee').is_open() then
    --     --         --     vim.cmd([[tabnew]])
    --     --         --     vim.cmd([[Dbee]])
    --     --         --     -- require('dbee').toggle()
    --     --         -- end
    --     --     end,
    --     --     desc = '[D]ata[B]ase',
    --     -- },
    -- },
    { -- E
        { '<leader>E', '<cmd>Neotree toggle left<CR>', desc = 'File Tree' },
        -- { '<leader>e', group = 'explore', icon = '󰙅' }, -- TODO: figure out icons
        -- { '<leader>ee', '<cmd>Neotree toggle current<CR>', desc = 'File Tree' },
        -- { '<leader>em', '<cmd>lua MiniFiles.open()<CR>', desc = 'File Tree' },
    },
    { -- F
        { '<leader>f', group = 'find' },
    },
    { -- G
        { '<leader>g', group = 'git' },
    },
    { -- J
        { 'jk', hidden = true, mode = { 'v' } },
    },
    -- { -- L
    --     { '<leader>l', '<cmd>Lazy<CR>', desc = '[L]azy' },
    -- },
    { -- M
        { '<leader>m', group = 'map' },
    },
    { -- N
        { '<leader>n', group = 'notif' },
    },
    { -- S
        { '<leader>s', group = 'show' },
        { '<leader>sk', '<cmd>ShowkeysToggle<CR>', desc = '[S]how [K]eys' },
    },
    { -- T
        { '<leader>t', group = 'toggle' },
        {
            '<leader>tn',
            function()
                vim.cmd([[tabnew]])
                vim.ui.input({ prompt = 'New Tab Name: ' }, function(input)
                    vim.cmd('BufferLineTabRename ' .. input)
                end)
            end,
            desc = '[N]ew Tab',
        },
    },
    { -- V
        { '<leader>v', desc = 'Select Treesitter Nodes' },
    },
})

require('todo-comments').setup({
    keywords = {
        DONE = { icon = ' ', color = 'info' },
        TODO = { icon = '󰵚 ', color = 'info' },
    },
    merge_keywords = true,
})

vim.keymap.set('n', ']t', function()
    require('todo-comments').jump_next()
end, { desc = 'Next [T]odo' })

vim.keymap.set('n', '[t', function()
    require('todo-comments').jump_prev()
end, { desc = 'Previous [T]odo' })

-- LUALINE --

local auto = require('lualine.themes.auto')
local lualine_modes = { 'insert', 'normal', 'visual', 'command', 'replace', 'inactive', 'terminal' }
for _, field in ipairs(lualine_modes) do
    if auto[field] and auto[field].c then
        auto[field].c.bg = 'NONE'
    end
end

-- local empty = require('lualine.component'):extend()
-- function empty:draw(default_highlight)
--     self.status = ''
--     self.applied_separator = ''
--     self:apply_highlights(default_highlight)
--     self:apply_section_separators()
--     return self.status
-- end

local map_space = require('lualine.component'):extend()
function map_space:init(options)
    self.applied_separator = ''
    map_space.super.init(self, options)
end

function map_space:update_status()
    local current_win_info = vim.fn.getwininfo(vim.api.nvim_get_current_win())[1]
    if
        (current_win_info.wincol + current_win_info.width - 1) == vim.o.columns
        -- and vim.api.nvim_get_mode().mode == 'c'
    then
        -- return '---------------'
        return '               '
    else
        return ''
    end
end

local lsp_servers = require('lualine.component'):extend()
function lsp_servers:init(options)
    options.icon = options.icon or '󰌘'
    options.split = options.split or ', '
    lsp_servers.super.init(self, options)
end

function lsp_servers:update_status()
    local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
    local buf_client_names = {}
    for _, client in pairs(buf_clients) do
        table.insert(buf_client_names, client.name)
    end
    return table.concat(buf_client_names, self.options.split)
end

vim.opt.showmode = false

local neominimap_statusline = require('neominimap.statusline')
local minimap_extension = {
    sections = {
        lualine_c = {
            neominimap_statusline.fullname,
        },
        lualine_z = {
            neominimap_statusline.position,
            'progress',
        },
    },
    filetypes = { 'neominimap' },
}

require('lualine').setup({
    options = {
        icons_enabled = true,
        -- theme = 'molokai',
        theme = auto,
        component_separators = { left = '│', right = '│' }, -- │
        -- component_separators = { left = '', right = '' },
        -- { left = '', right = '' }, { left = '', right = '' }, '|'
        -- section_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
            statusline = { 'dashboard', 'snacks_dashboard' },
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
                    added = require('icons').shapes.circle.plus .. ' ',
                    modified = require('icons').shapes.circle.dot .. ' ',
                    removed = require('icons').shapes.circle.minus .. ' ',
                    -- modified = require('icons').shapes.circle.dot .. ' ', --'~ ',
                    -- removed = require('icons').shapes.circle.outline .. ' ',
                },
                padding = { right = 1, left = 1 },
                source = function()
                    local gitsigns = vim.b.gitsigns_status_dict
                    local minidiff = vim.b.minidiff_summary
                    if gitsigns then
                        return {
                            added = gitsigns.added,
                            modified = gitsigns.changed,
                            removed = gitsigns.removed,
                        }
                    end
                    if minidiff then
                        return {
                            added = minidiff.add,
                            modified = minidiff.change,
                            removed = minidiff.delete,
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
            --     code_companion,
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
            { 'progress' },
        },
        lualine_y = {
            -- {
            --     require('lazy.status').updates,
            --     cond = require('lazy.status').has_updates,
            -- },
            {
                lsp_servers, -- current attached lsp servers
            },
        },
        lualine_z = {
            {
                'datetime',
                style = '%I:%M %p',
                -- separator = { left = '' },
                padding = { left = 1, right = 1 },
            },
            {
                map_space,
                -- draw_empty = true,
                -- padding = 8,
            },
        },
    },

    extensions = { minimap_extension, 'fzf', 'fugitive', 'mason', 'trouble', 'man' },
})
