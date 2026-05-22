vim.pack.add({
    { src = 'https://github.com/NickvanDyke/opencode.nvim', version = vim.version.range('*') },
})

local opencode_cmd = 'opencode --port'
---@type snacks.terminal.Opts
local snacks_terminal_opts = {
    win = {
        position = 'right',
        enter = false,
        on_win = function(win)
            -- Set up keymaps and cleanup for an arbitrary terminal
            require('opencode.terminal').setup(win.win)
        end,
    },
}
---@type opencode.Opts
vim.g.opencode_opts = {
    server = {
        start = function()
            require('snacks.terminal').open(opencode_cmd, snacks_terminal_opts)
        end,
        stop = function()
            require('snacks.terminal').get(opencode_cmd, snacks_terminal_opts):close()
        end,
        toggle = function()
            require('snacks.terminal').toggle(opencode_cmd, snacks_terminal_opts)
        end,
    },
}

-- Required for `opts.events.reload`.
vim.o.autoread = true

-- Recommended/example keymaps.
vim.keymap.set({ 'n', 'x' }, '<leader>oa', function()
    require('opencode').ask('@this: ', { submit = true })
end, { desc = 'Ask opencode...' })
vim.keymap.set({ 'n', 'x' }, '<leader>ox', function()
    require('opencode').select()
end, { desc = 'Execute opencode action…' })
vim.keymap.set({ 'n', 't' }, '<leader>oo', function()
    require('opencode').toggle()
end, { desc = 'Toggle opencode' })

vim.keymap.set({ 'n', 'x' }, 'go', function()
    return require('opencode').operator('@this ')
end, { desc = 'Add range to opencode', expr = true })
vim.keymap.set('n', 'goo', function()
    return require('opencode').operator('@this ') .. '_'
end, { desc = 'Add line to opencode', expr = true })

vim.keymap.set('n', '<S-C-u>', function()
    require('opencode').command('session.half.page.up')
end, { desc = 'Scroll opencode up' })
vim.keymap.set('n', '<S-C-d>', function()
    require('opencode').command('session.half.page.down')
end, { desc = 'Scroll opencode down' })
