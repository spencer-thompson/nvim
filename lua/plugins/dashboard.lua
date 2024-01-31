return {
    {
        "nvimdev/dashboard-nvim",
        event = "VimEnter",
        opts = function()

            -- local day = vim.api.nvim_cmd(


            local day = os.date('%A')
            -- local day = vim.api.nvim_exec2(
            --     '!pyfiglet --font=slant_relief -w 120 ' .. os.date('%A'),
            --     { output = true }
            -- ).output

            -- local newlinePos = string.find(day, "\n")
            -- if newlinePos then
            --     day = string.sub(day, newlinePos + 1)
            -- end

            local day = string.rep("\n", 4) .. day .. string.rep("\n", 4) -- .. text .. string.rep("\n", 4)


            local logo = "Neovim"
            -- local logo = vim.api.nvim_exec2(
            --     '!pyfiglet --font=slant_relief -w 120 Neovim',
            --     { output = true }
            -- ).output

            -- local newlinePos = string.find(logo, "\n")
            -- if newlinePos then
            --     logo = string.sub(logo, newlinePos + 1)
            -- end

            local logo = string.rep("\n", 4) .. logo .. string.rep("\n", 4) -- .. text .. string.rep("\n", 4)


            local opts = {
                theme = "doom",
                hide = {
                    -- this is taken care of by lualine
                    -- enabling this messes up the actual laststatus setting after loading a file
                    statusline = false,
                },
                config = {
                    header = vim.split(day, "\n"),
                    -- stylua: ignore
                    center = {
                        { action = "ene | startinsert", desc = " New file", icon = " ", key = "n" },
                        { action = "Telescope find_files", desc = " Find file", icon = " ", key = "f" }, -- 
                        { action = "Telescope live_grep", desc = " Find string", icon = " ", key = "s" },
                        { action = "TransparentToggle", desc = " Transparency", icon = " ", key = "t" },
                        -- { action = "Telescope oldfiles", desc = " Recent files", icon = " ", key = "r" },
                        { action = "Neotree toggle current", desc = " File Tree", icon = "󱏒 ", key = "e" },
                        -- { action = 'lua require("persistence").load()',     desc = " Restore Session", icon = " ", key = "s" },
                        -- { action = "LazyExtras",                            desc = " Lazy Extras",     icon = " ", key = "x" },
                        { action = "Lazy", desc = " Plugins", icon = "󰒲 ", key = "l" },
                        { action = "Mason", desc = " LSP & Formatting", icon = "󱌣 ", key = "m" },
                        { action = "qa", desc = " Quit", icon = " ", key = "q" },
                    },
                    footer = function()
                        local stats = require("lazy").stats()
                        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                        local lazy_msg = {
                            "⚡ Neovim loaded " ..
                            stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms"
                        }
                        local logo_stuff = vim.split(logo, "\n")
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
                button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
                button.key_format = "  %s"
            end

            -- close Lazy and re-open when the dashboard is ready
            if vim.o.filetype == "lazy" then
                vim.cmd.close()
                vim.api.nvim_create_autocmd("User", {
                    pattern = "DashboardLoaded",
                    callback = function()
                        require("lazy").show()
                    end,
                })
            end

            return opts
        end,
        config = function(_, opts)
            -- require('dashboard').setup(opts(randomFont(pyfiglet_fonts)))
            -- require('dashboard').setup(opts(randomFont()))
            require('dashboard').setup(opts)
        end,
    },
}
