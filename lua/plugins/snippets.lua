-- NOT WORKING
local ls = require('luasnip')

ls.config.set_config({
    history = false,
    updateevents = 'TextChanged,TextChangedI',
    enable_autosnippets = true,
    -- ext_opts = {
    -- [ls.util.types.choiceNode] = {
    --active = {
    -- virt_text = { { ' « ', 'NonTest' } },
    --},
    -- },
    -- },
})

-- create snippet
-- s(context, nodes, condition, ...)
-- local snippet = ls.s

vim.keymap.set({ 'i', 's' }, '<c-i>', function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end, { silent = true })

ls.snippets = {
    all = {
        ls.parser.parse_snippet('expand', '--what was expanded'),
    },
}
