return {
    root_markers = { 'pyproject.toml', 'ruff.toml', '.ruff.toml', '.git', '.venv' },
    cmd = { 'ruff', 'server' },
    filetypes = { 'python' },
    on_attach = function(client, _)
        client.server_capabilities.hoverProvider = false
    end,
}
