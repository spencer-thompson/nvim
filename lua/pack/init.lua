-- new experimental ui
require('vim._core.ui2').enable({ enable = true })

vim.keymap.set('n', '<leader>up', '<cmd>lua vim.pack.update()<cr>', { desc = '[U]pdate [P]lugins' })

-- mini
require('pack.blink')
require('pack.colors')
require('pack.format')
require('pack.fzf')
require('pack.mason')
require('pack.mini')
require('pack.snacks')
require('pack.treesitter')
require('pack.ui')
