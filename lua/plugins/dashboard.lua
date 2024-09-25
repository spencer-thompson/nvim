return {
    {
        'nvimdev/dashboard-nvim',
        name = 'dashboard',
        event = 'VimEnter',
        opts = function()
            local day = string.rep('\n', 1) .. require('plugins.ascii').randomDay(os.date('%A')) .. string.rep('\n', 2) -- .. text .. string.rep("\n", 4)

            local logo = string.rep('\n', 3) .. require('plugins.ascii').randomLogo() .. string.rep('\n', 1) -- .. text .. string.rep("\n", 4)

            local opts = {
                theme = 'doom',
                hide = {
                    statusline = false,
                },
                config = {
                    header = vim.split(day, '\n'),
                    -- stylua: ignore
                    center = {
                        { action = 'lua require("persistence").load()', desc = " Restore Session", icon = " ", key = "r" },
                        { action = "ene | startinsert",                 desc = " New file",        icon = " ", key = "n" },
                        { action = "Telescope find_files",              desc = " Find file",       icon = " ", key = "f" },
                        { action = "Telescope live_grep",               desc = " Find string",     icon = " ", key = "s" },
                        { action = "TransparentToggle",                 desc = " Transparency",    icon = " ", key = "t" },
                        { action = "lua MiniFiles.open()",              desc = " Explore Files",   icon = "󱏒 ", key = "e" },
                        { action = "Dbee",                              desc = " Database",        icon = "󱘲 ", key = "d" },
                        { action = "Neogit kind=floating",              desc = " Git",             icon = " ", key = "g" },
                        -- { action = "ChatGPT",                    desc = " ChatGPT",      icon = "󱚤 ", key = "c" },
                        -- { action = "ToggleTerm direction=float",        desc = " Terminal",     icon = " ", key = "t" },
                        { action = "Lazy",                              desc = " Lazy",            icon = "󰒲 ", key = "l" },
                        { action = "Mason",                             desc = " Mason",           icon = "󱌣 ", key = "m" },
                        { action = "qa",                                desc = " Quit",            icon = " ", key = "q" },
                        -- { action = "Telescope oldfiles", desc = " Recent files", icon = " ", key = "r" },
                        -- { action = "LazyExtras",                            desc = " Lazy Extras",     icon = " ", key = "x" },
                    },
                    footer = function()
                        local stats = require('lazy').stats()
                        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                        local lazy_msg = {
                            '⚡ Neovim loaded ' .. stats.loaded .. '/' .. stats.count .. ' plugins in ' .. ms .. 'ms',
                        }
                        -- if require('lazy.status').has_updates() then
                        --     -- lazy_msg = string.rep('\n', 1) .. lazy_msg .. require('lazy.status').updates() .. 'available'
                        --     local updates = require('lazy.status').updates() .. 'available'
                        --     table.insert(lazy_msg, string.rep('\n', 1))
                        --     table.insert(lazy_msg, updates)
                        --     table.insert(lazy_msg, string.rep('\n', 1))
                        -- end
                        local logo_stuff = vim.split(logo, '\n')
                        for i = 1, #logo_stuff do
                            table.insert(lazy_msg, logo_stuff[i])
                        end

                        return lazy_msg
                        -- return {
                        --     "⚡ Neovim loaded " ..
                        --     stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms",
                        --     -- vim.split(logo, "\n"), -- .. vim.split(logo, "\n")
                        -- }
                    end,
                },
            }

            for _, button in ipairs(opts.config.center) do
                button.desc = button.desc .. string.rep(' ', 43 - #button.desc)
                button.key_format = '  %s'
            end

            -- close Lazy and re-open when the dashboard is ready
            if vim.o.filetype == 'lazy' then
                vim.cmd.close()
                vim.api.nvim_create_autocmd('User', {
                    pattern = 'DashboardLoaded',
                    callback = function()
                        require('lazy').show()
                    end,
                })
            end

            return opts
        end,

        config = function(_, opts)
            require('dashboard').setup(opts)
        end,
    },
}
