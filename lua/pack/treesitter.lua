vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if name == 'nvim-treesitter' and kind == 'update' then
            if not ev.data.active then
                vim.cmd.packadd('nvim-treesitter')
            end
            vim.cmd('TSUpdate')
        end
    end,
})

vim.pack.add({
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects', version = 'main' },
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
    { src = 'https://github.com/folke/ts-comments.nvim', version = 'main' },
})

require('nvim-treesitter-textobjects').setup({
    move = {
        enable = true,
        set_jumps = true,
    },
    swap = {
        enable = true,
    },
})

vim.keymap.set('n', '<leader>sa', function()
    require('nvim-treesitter-textobjects.swap').swap_next('@parameter.inner')
end, { desc = '[S]wap Next [A]rgument' })

local group = vim.api.nvim_create_augroup('custom-treesitter', { clear = true })

require('nvim-treesitter').setup({
    ensure_installed = {
        'core',
        'stable',
    },

    auto_install = true,

    -- install_dir = vim.fn.stdpath('data') .. '/site',
})

vim.api.nvim_create_autocmd('Filetype', {
    group = group,
    callback = function(args)
        local ok, parser = pcall(vim.treesitter.get_parser, args.buf)
        if not ok or not parser then
            return
        end

        pcall(vim.treesitter.start)
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})

vim.keymap.set('n', '<leader>ui', '<cmd>InspectTree<cr>', { desc = 'Inspect Highlights' })
