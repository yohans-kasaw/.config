vim.api.nvim_create_autocmd("FileType", {
    pattern = "qf",
    callback = function(args)
        vim.api.nvim_buf_set_keymap(args.buf, "n", "q", "<cmd>cclose<cr>", { noremap = true, silent = true })
    end,
    desc = "Close quickfix window with q",
})

-- Group 1: Modern Web and Data (2 Spaces)
vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "javascriptreact",
        "typescriptreact",
        "vue",
        "svelte",
        "astro",
        "html",
        "css",
        "less",
        "scss",
        "json",
        "jsonc",
        "yaml",
        "toml",
        "graphql",
        "markdown",
        "xml",
    },
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
        vim.opt_local.expandtab = true
    end,
})

-- Group 2: Systems, Backend, and Scripts (4 Spaces)
vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "javascript",
        "typescript",
        "python",
        "c",
        "cpp",
        "java",
        "go",
        "rust",
        "php",
        "sql",
        "dockerfile",
        "cmake",
        "lua",
        "sh",
        "fish",
        "zsh",
        "conf",
    },
    callback = function()
        vim.opt_local.tabstop = 4
        vim.opt_local.shiftwidth = 4
        vim.opt_local.expandtab = true
    end,
})
