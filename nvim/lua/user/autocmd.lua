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
        "javascript",
        "typescript",
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


vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, {
    callback = function(args)
        local ft = vim.bo[args.buf].filetype
        if vim.tbl_contains({ "markdown", "text" }, ft) then
            vim.opt_local.spell = true
            vim.opt_local.spelllang = { "en_us" }
        end
    end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "svelte",
  callback = function()
    vim.treesitter.start()
  end,
})
