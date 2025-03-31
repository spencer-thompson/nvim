return {
    cmd = { 'basedpyright-langserver', '--stdio' },
    root_markers = {
        '.venv',
        '.env',
        'pyproject.toml',
        'setup.py',
        'setup.cfg',
        'requirements.txt',
        'Pipfile',
        'pyrightconfig.json',
        '.git',
    },
    filetypes = { 'python' },

    settings = {
        basedpyright = {
            -- autoImportCompletion = true,
            disableOrganizeImports = true, -- Using Ruff
            analysis = {
                ignore = { '*' },
                autoSearchPaths = true,
                diagnosticMode = 'openFilesOnly',
                useLibraryCodeForTypes = true,
                typeCheckingMode = 'off', -- try basic eventually
            },
        },
        python = {
            venvPath = Snacks.git.get_root(), -- This works?
        },
    },
}
