local M = {}

local path = vim.fn.stdpath('state') .. '/nvim-mcp'

vim.api.nvim_create_autocmd({ 'VimEnter', 'FocusGained', 'BufEnter' }, {
    callback = function()
        if vim.v.servername ~= nil and vim.v.servername ~= '' then
            vim.fn.writefile({ vim.v.servername }, path)
        end
    end,
})

function M.set_quickfix_list(items)
    local qf_items = vim.tbl_map(function(item)
        return {
            filename = item.filename,
            lnum = item.lnum or 1,
            col = item.col or 1,
            text = item.text or item.path,
            -- user_data = {
            --     title = item.title,
            --     note = item.note,
            -- },
        }
    end, items)

    vim.fn.setqflist({}, ' ', {
        title = 'AI Tour',
        items = qf_items,
    })

    vim.cmd.copen()
    -- vim.cmd.cc(1)
end

-- function M.show_ai_quickfix_note()
--     -- vim.api.nvim_echo()
--
--     local qf = vim.fn.getqflist({
--         idx = 1,
--         items = 1,
--         title = 1,
--     })
--
--     if qf.title ~= 'AI Tour' then
--         return
--     end
--
--     local item = qf.items[qf.idx]
--     if not item then
--         return
--     end
--
--     local data = item.user_data or {}
--     local title = data.title or item.text or 'AI Tour'
--     local note = data.note or item.text or ''
--
--     if note == '' then
--         return
--     end
--
--     vim.notify(note, vim.log.levels.INFO, {
--         title = title,
--     })
-- end
--
-- vim.keymap.set('n', '<leader>an', M.show_ai_quickfix_note, { desc = 'Show AI Note' })

return M
