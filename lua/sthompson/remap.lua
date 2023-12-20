-- file tree
-- vim.keymap.set('n', '<leader>e', vim.cmd('NvimTreeToggle'))

local opts = { noremap = true, silent = true }

-- jk to leave insert mode
vim.keymap.set({"i", "v"}, "jk", "<Esc>")

-- move lines up or down in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Cycle through windows
vim.keymap.set('n', '<Tab>', '<C-w>w')
vim.keymap.set('n', '<S-Tab>', '<C-w>W')

-- move through buffers
vim.keymap.set('n', '<leader>n', '<cmd>bnext<CR>')
vim.keymap.set('n', '<leader>N', '<cmd>bprevious<CR>')
vim.keymap.set('n', '<leader>c', '<cmd>bdelete<CR>')
vim.keymap.set('n', '<leader>db', '<cmd>Dashboard<CR>')

-- visual block mode
vim.keymap.set('n', 'vb', '<C-v>')

vim.keymap.set("n", "x", '"_x') -- doesn't add to register

-- center the window
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- increment / decrement
vim.keymap.set("n", "+", "<C-a>")
vim.keymap.set("n", "-", "<C-x>")

-- save
vim.keymap.set({"i", "n"}, "<C-s>", vim.cmd.write)

--format
vim.keymap.set("n", "<leader>fo", vim.lsp.buf.format)

-- select all
vim.keymap.set("n", "<C-a>", "gg<S-v>G")

-- splits
vim.keymap.set("n", "<leader>hs", "<cmd>split<CR>", opts)
vim.keymap.set("n", "<leader>vs", "<cmd>vsplit<CR>", opts)
-- move window
vim.keymap.set({"n", "t"}, "<C-h>", "<C-w>h")
vim.keymap.set({"n", "t"}, "<C-k>", "<C-w>k")
vim.keymap.set({"n", "t"}, "<C-j>", "<C-w>j")
vim.keymap.set({"n", "t"}, "<C-l>", "<C-w>l")
-- move in insert mode
vim.keymap.set("i", "<A-h>", "<left>")
vim.keymap.set("i", "<A-k>", "<up>")
vim.keymap.set("i", "<A-j>", "<down>")
vim.keymap.set("i", "<A-l>", "<right>")

-- quit
vim.keymap.set("n", "<leader>q", "<cmd>q<CR>")
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>")
vim.keymap.set("n", "Q", "<nop>")
-- quick source
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

