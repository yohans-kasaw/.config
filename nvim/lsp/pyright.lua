return
{
    name = 'pyright',
    cmd = { 'pyright-langserver', '--stdio' },
    root_dir = vim.fs.root(0, { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', '.git' }),
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = 'workspace',
            },
        },
    },
}
