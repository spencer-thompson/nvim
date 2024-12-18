return {

    -- { 'tpope/vim-fugitive', name = 'fugitive', event = 'VeryLazy' },

    {
        'NeogitOrg/neogit',
        enabled = false,
        event = 'VeryLazy',
        dependencies = {
            { 'sindrets/diffview.nvim', name = 'diffview' },
        },
        keys = {
            {
                '<leader>gg',
                function()
                    vim.cmd([[Neogit kind=floating]])
                end,
                desc = 'Neogit',
            },
        },
        opts = {
            commit_editor = {
                kind = 'floating',
                show_staged_diff = true,
                -- Accepted values:
                -- "split" to show the staged diff below the commit editor
                -- "vsplit" to show it to the right
                -- "split_above" Like :top split
                -- "vsplit_left" like :vsplit, but open to the left
                -- "auto" "vsplit" if window would have 80 cols, otherwise "split"
                staged_diff_split_kind = 'split',
                spell_check = true,
            },
            commit_select_view = {
                kind = 'floating',
            },
            commit_view = {
                kind = 'floating',
                verify_commit = vim.fn.executable('gpg') == 1, -- Can be set to true or false, otherwise we try to find the binary
            },
            log_view = {
                kind = 'floating',
            },
            rebase_editor = {
                kind = 'auto',
            },
            reflog_view = {
                kind = 'floating',
            },
            merge_editor = {
                kind = 'auto',
            },
            tag_editor = {
                kind = 'auto',
            },
            preview_buffer = {
                kind = 'floating',
            },
            popup = {
                kind = 'floating',
            },

            commit_popup = { kind = 'floating' },
        },
        config = true,
    },

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

    {
        'lewis6991/gitsigns.nvim',
        name = 'gitsigns',
        event = 'VeryLazy',
        lazy = true,
        opts = {
            -- signs = {
            --     add = { text = '▎' },
            --     change = { text = '▎' },
            --     delete = { text = '' },
            --     topdelete = { text = '' },
            --     changedelete = { text = '▎' },
            --     untracked = { text = '▎' },
            -- },
            signs = { --🮇'▎'
                add = { text = '▎' },
                change = { text = '▎' },
                delete = { text = '▎' },
                topdelete = { text = '▎' },
                changedelete = { text = '▎' },
                untracked = { text = '▎' },
            },
            numhl = false,
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
        },
        config = function(_, opts)
            require('gitsigns').setup(opts)
        end,
    },

    -- { 'rhysd/git-messenger.vim', name = 'git-messenger', event = 'VeryLazy' },

    -- { "rhysd/committia.vim",     event = "VeryLazy" },
}
