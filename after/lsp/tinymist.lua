return {

    root_markers = function(_, bufnr)
        return vim.fn.expand('%:p:h')
    end,
    filetypes = { 'typst' },
    cmd = { 'tinymist' },
    on_init = function(client, _)
        client.server_capabilities.semanticTokensProvider = nil -- turn off semantic tokens
        client.settings = {
            root_dir = function(_, bufnr)
                return vim.fn.expand('%:p:h')
            end,
        }
    end,

    settings = {
        formatterMode = 'typstyle',
        outputPath = '$root/$dir/$name',
        exportPdf = 'onSave',
    },
}
