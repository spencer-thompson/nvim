return {
    "nvimtools/none-ls.nvim",
    config = function()
        local null_ls = require("null-ls")

        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.stylua,
                -- null_ls.builtins.formatting.format_r, -- R code
                null_ls.builtins.formatting.json_tool,   -- install
                null_ls.builtins.formatting.latexindent, -- install
                -- remark for markdown?


            }
        })

        vim.keymap.set('n', "<leader>fm", vim.lsp.buf.format, { noremap = true, silent = true, desc = "Format" })
    end
}