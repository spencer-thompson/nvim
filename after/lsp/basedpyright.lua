local markers = {
    'pyproject.toml',
    '.venv/',
    -- '.git',
}

return {
    cmd = { 'basedpyright-langserver', '--stdio' },
    root_markers = markers,
    -- root_markers = {
    --     '.venv',
    --     -- '.env',
    --     'pyproject.toml',
    --     'setup.py',
    --     'setup.cfg',
    --     -- 'requirements.txt',
    --     'Pipfile',
    --     -- 'pyrightconfig.json',
    --     '.git',
    -- },
    filetypes = { 'python' },
    handlers = {
        ['textDocument/publishDiagnostics'] = function() end,
    },

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
        -- python = {
        --     venvPath = vim.fs.root(0, '.venv'), -- This works?
        -- },
    },
}
