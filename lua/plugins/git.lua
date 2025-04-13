return {

    {
        'isakbm/gitgraph.nvim',
        enabled = false,
        opts = {
            symbols = {
                merge_commit = 'M',
                commit = '*',
            },
            format = {
                timestamp = '%H:%M:%S %d-%m-%Y',
                fields = { 'hash', 'timestamp', 'author', 'branch_name', 'tag' },
            },
            hooks = {
                -- Check diff of a commit
                on_select_commit = function(commit)
                    vim.notify('DiffviewOpen ' .. commit.hash .. '^!')
                    vim.cmd(':DiffviewOpen ' .. commit.hash .. '^!')
                end,
                -- Check diff from commit a -> commit b
                on_select_range_commit = function(from, to)
                    vim.notify('DiffviewOpen ' .. from.hash .. '~1..' .. to.hash)
                    vim.cmd(':DiffviewOpen ' .. from.hash .. '~1..' .. to.hash)
                end,
            },
        },
        keys = {
            {
                '<leader>gl',
                function()
                    require('gitgraph').draw({}, { all = true, max_count = 5000 })
                end,
                desc = 'GitGraph - Draw',
            },
        },
    },

    { -- somehow deleted?
        'sindrets/diffview.nvim',
        name = 'diffview',
        event = 'VeryLazy',
    },

    { -- vscode like highlights on git changes
        'lewis6991/gitsigns.nvim',
        name = 'gitsigns',
        event = 'VeryLazy',
        enabled = false,
        lazy = true,
        config = function(_, opts)
            local bar = require('icons').lines.left.vertical
            require('gitsigns').setup({
                -- signs = {
                --     add = { text = '▎' },
                --     change = { text = '▎' },
                --     delete = { text = '' },
                --     topdelete = { text = '' },
                --     changedelete = { text = '▎' },
                --     untracked = { text = '▎' },
                -- },
                signs = { --🮇'▎'
                    add = { text = bar },
                    change = { text = bar },
                    delete = { text = bar },
                    topdelete = { text = bar },
                    changedelete = { text = bar },
                    untracked = { text = bar },
                },
                signs_staged = {
                    add = { text = bar },
                    change = { text = bar },
                    delete = { text = bar },
                    topdelete = { text = bar },
                    changedelete = { text = bar },
                    untracked = { text = bar },
                },
                numhl = false,
                signcolumn = false,
                current_line_blame = true,
                -- current_line_blame_formatter = '    - <author> | <author_time:[%a %I:%M %p]> | "<summary>"',
                current_line_blame_opts = {
                    virt_text_pos = 'eol',
                    delay = 200,
                },
                on_attach = function(buffer)
                    local gs = package.loaded.gitsigns

                    local function map(mode, l, r, desc)
                        vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
                    end

                -- stylua: ignore start
                map("n", "]g", gs.next_hunk, "Next Hunk")
                map("n", "[g", gs.prev_hunk, "Prev Hunk")
                map({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
                map({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
                map("n", "<leader>gS", gs.stage_buffer, "Stage Buffer")
                map("n", "<leader>gu", gs.undo_stage_hunk, "Undo Stage Hunk")
                map("n", "<leader>gR", gs.reset_buffer, "Reset Buffer")
                map("n", "<leader>gp", gs.preview_hunk, "Preview Hunk")
                -- map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "Blame Line")
                map("n", "<leader>gd", gs.diffthis, "Diff This")
                map("n", "<leader>gD", function() gs.diffthis("~") end, "Diff This ~")
                map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
                map("n", "<leader>tg", gs.toggle_current_line_blame, "Line Blame")
                end,
            })
        end,
    },
}
