return {
    settings = {
        ['harper-ls'] = {
            userDictPath = '~/dotfiles/.config/nvim/dict/valid_words.txt',
            linters = {
                SentenceCapitalization = false,
                SpellCheck = false,
            },
        },
    },
    cmd = { 'harper-ls', '--stdio' },
    root_markers = function(fname)
        return vim.fs.dirname(vim.fs.find('.git', { path = fname, upward = true })[1])
    end,
    filetypes = {
        'c',
        'cpp',
        'cs',
        'gitcommit',
        'go',
        'html',
        'java',
        'javascript',
        -- 'lua',
        'markdown',
        'nix',
        -- 'python',
        'ruby',
        'rust',
        'swift',
        'toml',
        'typescript',
        'typescriptreact',
        'haskell',
        'cmake',
        'typst',
        'php',
        'dart',
    },
}
