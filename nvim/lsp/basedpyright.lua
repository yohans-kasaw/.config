return {
    cmd = { 'basedpyright-langserver', '--stdio' },
    filetypes = { 'python' },
        root_markers = {
            'pyproject.toml',
            'requirements.txt',
            '.git',
    },
    settings = {
        basedpyright = {
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                analyzeUnannotatedFunctions = true,
                strictParameterNoneValue = true,
                reportMissingTypeStubs = true,
                reportImportCycles = true,
                reportUnreachable = true,
                reportPrivateImportUsage = true,
                diagnosticMode = "workspace",
                typeCheckingMode = 'recommended',
            },
        },
    },
}
