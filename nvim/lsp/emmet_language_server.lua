return {
    cmd = { "emmet-language-server", "--stdio" },
    root_dir = vim.fs.dirname(vim.fs.find({ ".git" }, { upward = true })[1]),
    filetypes = {
        "css",
        "html",
        "javascript",
        "javascriptreact",
        "less",
        "sass",
        "scss",
        "pug",
        "typescriptreact",
    },
    init_options = {
        ---@type table<string, string>
        includeLanguages = {},
        --- @type string[]
        excludeLanguages = {},
        --- @type string[]
        extensionsPath = {},
        --- @type table<string, any>
        preferences = {},
        --- @type boolean Defaults to `true`
        showAbbreviationSuggestions = true,
        --- @type "always" | "never" Defaults to `"always"`
        showExpandedAbbreviation = "always",
        --- @type boolean Defaults to `false`
        showSuggestionsAsSnippets = false,
        --- @type table<string, any>
        syntaxProfiles = {},
        --- @type table<string, string>
        variables = {},
    },
}
