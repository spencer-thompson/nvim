-- "flashes" the yanked text
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 100 })
    end,
    group = highlight_group,
    pattern = '*',
})

-- turn off spell check in the terminal
local terminal_spell = vim.api.nvim_create_augroup('TermSpellCheck', { clear = true })
vim.api.nvim_create_autocmd('TermOpen', {
    callback = function()
        vim.opt_local.spell = false
    end,
    group = terminal_spell,
})

-- close with q
vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('close_with_q', { clear = true }),
    desc = 'Close with <q>',
    pattern = {
        'git',
        'help',
        'man',
        'qf',
        'query',
        'scratch',
    },
    callback = function(args)
        vim.keymap.set('n', 'q', '<cmd>quit<cr>', { buffer = args.buf })
    end,
})

-- dynamic sidescrolloff
vim.api.nvim_create_autocmd({ 'WinResized', 'BufEnter' }, {
    group = vim.api.nvim_create_augroup('dynamic_sidescrolloff', { clear = true }),
    desc = 'Dynamic sidescrolloff',
    callback = function(args)
        local height = vim.fn.winheight(0)
        local width = vim.fn.winwidth(0)
        local factor = 7
        -- vim.opt.scrolloff = (height > 30) and math.floor(height / 6) or math.floor(height / 12) -- testing .......................................
        -- vim.opt.sidescrolloff = (width >= 100) and math.floor(width / 5) or math.floor(width / 10)
        vim.opt.scrolloff = math.floor(height / factor)
        vim.opt.sidescrolloff = math.floor(width / (factor - 1))
    end,
})

-- Go to the last location when opening a buffer
vim.api.nvim_create_autocmd('BufReadPost', {
    group = vim.api.nvim_create_augroup('last_location', { clear = true }),
    desc = 'Go to the last location when opening a buffer',
    callback = function(args)
        local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
        local line_count = vim.api.nvim_buf_line_count(args.buf)
        if mark[1] > 0 and mark[1] <= line_count then
            vim.cmd('normal! g`"zz')
        end
    end,
})

vim.api.nvim_create_autocmd('CmdlineEnter', {
    group = vim.api.nvim_create_augroup('search_highlight', { clear = true }),
    desc = 'Start Highlight Search',
    callback = function(args)
        if args.match == '/' or args.match == '?' then
            vim.v.hlsearch = 1
        end
    end,
})

vim.api.nvim_create_autocmd('CmdlineLeave', {
    group = vim.api.nvim_create_augroup('search_highlight', { clear = true }),
    desc = 'Stop Highlight Search',
    callback = function(args)
        if args.match == '/' or args.match == '?' then
            vim.defer_fn(function()
                vim.cmd.nohl()
            end, 1000)
        end
    end,
})

-- vim.api.nvim_create_autocmd('BufLeave', {
--     group = vim.api.nvim_create_augroup('close_terms', { clear = true }),
--     desc = 'Close Terminals on Exit',
--     pattern = 'term://*',
--     command = 'quit',
-- })
