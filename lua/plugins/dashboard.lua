return {
    {
        "nvimdev/dashboard-nvim",
        event = "VimEnter",
        opts = function()
            local logo = [[
             /\\\\\_____/\\\_______________________________/\\\________/\\\___________________________         
             \/\\\\\\___\/\\\______________________________\/\\\_______\/\\\__________________________         
             _\/\\\/\\\__\/\\\______________________________\//\\\______/\\\___/\\\_____________________       
              _\/\\\//\\\_\/\\\_____/\\\\\\\\______/\\\\\_____\//\\\____/\\\___\///_____/\\\\\__/\\\\\__       
               _\/\\\\//\\\\/\\\___/\\\/////\\\___/\\\///\\\____\//\\\__/\\\_____/\\\__/\\\///\\\\\///\\\_     
                _\/\\\_\//\\\/\\\__/\\\\\\\\\\\___/\\\__\//\\\____\//\\\/\\\_____\/\\\_\/\\\_\//\\\__\/\\\     
                 _\/\\\__\//\\\\\\_\//\\///////___\//\\\__/\\\______\//\\\\\______\/\\\_\/\\\__\/\\\__\/\\\_   
                  _\/\\\___\//\\\\\__\//\\\\\\\\\\__\///\\\\\/________\//\\\_______\/\\\_\/\\\__\/\\\__\/\\\   
                   _\///_____\/////____\//////////_____\/////___________\///________\///__\///___\///___\///__ 
            ]]

            logo = string.rep("\n", 4) .. logo .. string.rep("\n", 4)

            local opts = {
                theme = "doom",
                hide = {
                    -- this is taken care of by lualine
                    -- enabling this messes up the actual laststatus setting after loading a file
                    statusline = false,
                },
                config = {
                    header = vim.split(logo, "\n"),
                    -- stylua: ignore
                    center = {
                        { action = "Telescope find_files",                                     desc = " Find file",       icon = " ", key = "f" },
                        { action = "ene | startinsert",                                        desc = " New file",        icon = " ", key = "n" },
                        { action = "Telescope oldfiles",                                       desc = " Recent files",    icon = " ", key = "r" },
                        { action = "Telescope live_grep",                                      desc = " Find text",       icon = " ", key = "g" },
                        { action = [[lua require("lazyvim.util").telescope.config_files()()]], desc = " Config",          icon = " ", key = "c" },
                        { action = 'lua require("persistence").load()',                        desc = " Restore Session", icon = " ", key = "s" },
                        -- { action = "LazyExtras",                                               desc = " Lazy Extras",     icon = " ", key = "x" },
                        { action = "Lazy",                                                     desc = " Plugins",         icon = "󰒲 ", key = "l" },
                        { action = "qa",                                                       desc = " Quit",            icon = " ", key = "q" },
                    },
                    footer = function()
                        local stats = require("lazy").stats()
                        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                        return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
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
    }
}

