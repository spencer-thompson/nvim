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
    'ansi_shadow',
    'bloody',
    'calvin_s',
    'cards',
    'cyberlarge',
    'cybermedium',
    'doom',
    'dos_rebel',
    'hollywood',
    'pepper',
    'slant_relief',
    'starwars',
    'sub-zero',
    'swamp_land',
    'the_edge',
    'this',
    'twisted',
    'univers',
}

function RandomChoice(table)
    local randomIndex = math.random(#table)
    return table[randomIndex]
end
