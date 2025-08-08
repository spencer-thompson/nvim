return {
    cmd = { 'docker-language-server', 'start', '--stdio' },
    filetypes = { 'dockerfile', 'yaml.docker-compose' },
    root_markers = {
        '.git',
        'Dockerfile',
        'docker-compose.yaml',
        'docker-compose.yml',
        'compose.yaml',
        'compose.yml',
        'docker-bake.json',
        'docker-bake.hcl',
        'docker-bake.override.json',
        'docker-bake.override.hcl',
    },
}
