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
