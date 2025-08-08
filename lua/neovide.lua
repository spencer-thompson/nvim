if vim.g.neovide then
    -- Font
    -- vim.opt.guifont = 'Berkeley Mono:h12:#e-subpixelantialias:#h-normal'
    -- vim.o.guifont = 'Berkeley Mono:h12:#e-subpixelantialias:#h-slight'
    -- vim.o.guifont = 'Berkeley Mono:h10:#e-subpixelantialias'
    vim.o.guifont = 'Berkeley Mono:h12:b'
    -- vim.o.guifont = 'JetBrainsMonoNF:h12'

    -- Helper function for transparency formatting
    local alpha = function()
        return string.format('%x', math.floor(0.8))
    end

    -- machine specific settings
    -- local hostname = vim.system({ 'hostname' }, { text = true }):wait().stdout
    -- if hostname == 'desktop' then
    --     vim.g.neovide_refresh_rate = 100
    -- elseif hostname == 'sthom' then
    --     vim.g.neovide_refresh_rate = 165
    -- else
    --     vim.g.neovide_refresh_rate = 120
    -- end

    -- vim.g.neovide_transparency = 0.8
    vim.g.neovide_opacity = 0.8
    vim.g.transparency = 0.8
    vim.g.neovide_window_blurred = true
    vim.g.neovide_floating_blur_amount_x = 2.0
    vim.g.neovide_floating_blur_amount_y = 2.0

    -- vim.g.neovide_background_color = '#0f1117' .. alpha()

    vim.g.neovide_cursor_vfx_mode = 'wireframe'
    -- vim.g.neovide_cursor_vfx_mode = 'pixiedust'
    vim.g.neovide_cursor_smooth_blink = false
    -- vim.g.neovide_cursor_vfx_particle_density = 16.8
    -- vim.g.neovide_cursor_vfx_particle_lifetime = 2.2
    -- vim.g.neovide_cursor_vfx_particle_phase = 1.2
    -- vim.g.neovide_cursor_vfx_particle_curl = 1.0
    -- vim.g.neovide_cursor_animation_length = 0.08
    -- vim.g.neovide_cursor_trail_size = 0.8

    -- floating shadow
    vim.g.neovide_floating_shadow = true
    vim.g.neovide_floating_z_height = 10
    vim.g.neovide_light_angle_degrees = 45
    vim.g.neovide_light_radius = 3
    vim.g.neovide_floating_blur_amount_x = 1.0
    vim.g.neovide_floating_blur_amount_y = 1.0
    vim.g.neovide_floating_corner_radius = 0.50
    -- scaling
    vim.g.neovide_scale_factor = 1.0

    vim.g.neovide_text_gamma = 1.0
    vim.g.neovide_text_contrast = 0.1

    vim.g.neovide_padding_top = 0
    vim.g.neovide_padding_bottom = 0
    vim.g.neovide_padding_right = 0
    vim.g.neovide_padding_left = 0

    -- Hide commandline
    vim.o.laststatus = 0
    vim.o.cmdheight = 0
end
