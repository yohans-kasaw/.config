return {
    cmd = { 'ruff', 'server' },
    filetypes = { 'python' },
    root_dir = vim.fs.root(0, { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', '.git' }),
    single_file_support = true,
    settings = {},
}
