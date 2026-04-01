vim.pack.add({
    { src = 'https://github.com/akinsho/bufferline.nvim', version = vim.version.range('*') },
    { src = 'https://github.com/Isrothy/neominimap.nvim' },
    { src = 'https://github.com/folke/which-key.nvim' },
})

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

vim.g.neominimap = {
    auto_enable = true,
    notification_level = vim.log.levels.OFF,
    layout = 'float',
    delay = 50,
    float = {
        window_border = 'none',
        minimap_width = 18,
        z_index = 1,
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
    -- git = { enabled = true, mode = 'sign' },
    search = { enabled = true, mode = 'sign', priority = 20 },
    mark = { enabled = true, mode = 'sign', priority = 100 },
    fold = {
        enabled = true,
    },
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
