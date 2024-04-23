-- local options
vim.opt_local.shiftwidth = 2
-- vim.opt_local.textwidth = 80
vim.opt_local.wrap = true
vim.opt_local.ff = 'unix'

vim.b.markdown_pdf_preview = false

-- auto commands
local group = vim.api.nvim_create_augroup('Markdown PDF Preview', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
    desc = 'Live update compiled PDF',
    pattern = '*.md',
    group = group,
    callback = function()
        if vim.b.markdown_pdf_preview then
            vim.cmd([[silent !pandoc -i % -o "%:r".pdf]])
        end
    end,
})

-- local keymaps
vim.api.nvim_buf_set_keymap(0, 'n', '<leader>r', '<cmd>MarkdownPreview<CR>', { desc = 'Markdown Preview' })
vim.keymap.set('n', '<leader>R', function()
    if vim.b.markdown_pdf_preview then
        vim.b.markdown_pdf_preview = false
    else
        vim.b.markdown_pdf_preview = true
        vim.cmd([[silent !pandoc -i % -o "%:r".pdf]])
        vim.cmd([[silent !zathura "%:r".pdf &]])
    end
end, { desc = 'Markdown PDF Preview' })

vim.api.nvim_buf_set_keymap(
    0,
    'n',
    '<leader>p',
    '<cmd>execute "!pandoc -i % -o " expand("%:r") .. ".pdf"<CR>',
    { desc = 'Pandoc -> PDF' }
)
