-- new experimental ui
require('vim._core.ui2').enable({ enable = true })

vim.keymap.set('n', '<leader>up', '<cmd>lua vim.pack.update()<cr>', { desc = '[U]pdate [P]lugins' })

vim.cmd('packadd nvim.undotree')
vim.keymap.set('n', '<leader>ut', require('undotree').open, { desc = '[U]ndo[t]ree' })

-- mini
require('pack.snacks')
require('pack.mini')
require('pack.colors')
require('pack.ui')
require('pack.blink')
require('pack.format')
require('pack.fzf')
require('pack.treesitter')
require('pack.mason')
require('pack.terminal')
require('pack.motions')
