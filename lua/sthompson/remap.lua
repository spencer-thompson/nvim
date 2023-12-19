-- file tree
-- vim.keymap.set('n', '<leader>e', vim.cmd('NvimTreeToggle'))

local opts = { noremap = true, silent = true }

-- visual block mode
vim.keymap.set('n', 'vb', '<C-v>')

vim.keymap.set("n", "x", '"_x') -- doesn't add to register

-- increment / decrement
vim.keymap.set("n", "+", "<C-a>")
vim.keymap.set("n", "-", "<C-x>")

-- save
vim.keymap.set({"i", "n"}, "<C-s>", vim.cmd.write)

-- select all
vim.keymap.set("n", "<C-a>", "gg<S-v>G")

-- splits
vim.keymap.set("n", "<leader>ss", "<cmd>split<CR>", opts)
vim.keymap.set("n", "<leader>sv", "<cmd>vsplit<CR>", opts)
-- move window
vim.keymap.set({"n", "t"}, "<C-h>", "<C-w>h")
vim.keymap.set({"n", "t"}, "<C-k>", "<C-w>k")
vim.keymap.set({"n", "t"}, "<C-j>", "<C-w>j")
vim.keymap.set({"n", "t"}, "<C-l>", "<C-w>l")

-- quick source
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

