-- pyfiglet
function pyfiglet(message, font)
    font = font or 'standard'
    return vim.api.nvim_cmd(
        {
            cmd = '!pyfiglet ' .. '--font=' .. font .. ' ' .. message,
            bang = true,
        },
        { output = true }
    )
end

local pyfiglet_fonts = {
    'univers',
    'twisted',
    'this',
    'the_edge',
    'swamp_land',
    'sub-zero',
    'starwars',
    'slant_relief',
    'pepper',
    'hollywood',
    'dos_rebel',
    'doom',
    'cybermedium',
    'cyberlarge',
    'cards',
    'calvin_s',
    'bloody',
    'ansi_shadow',
}

-- function randomFont(table)
function randomFont()
    if #pyfiglet_fonts == 0 then
        return 'standard'
    end
    local index = math.random(#pyfiglet_fonts)
    return pyfiglet_fonts[index]
end
