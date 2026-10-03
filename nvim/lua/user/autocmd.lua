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

local augroup = vim.api.nvim_create_augroup("UserEmptyBufferFzf", { clear = true })

vim.api.nvim_create_autocmd("BufEnter", {
    group = augroup,
    callback = function(args)
        local buf = args.buf

        -- Must be a normal, listed, loaded buffer
        if not vim.api.nvim_buf_is_loaded(buf) then return end
        if vim.bo[buf].buftype ~= "" then return end          -- skip oil, terminals, help, quickfix, etc.
        if not vim.bo[buf].buflisted then return end
        if vim.bo[buf].filetype == "oil" then return end       -- explicit, in case oil sets it
        if vim.api.nvim_buf_get_name(buf) ~= "" then return end -- has a filename
        if vim.bo[buf].modified then return end                -- has unsaved edits

        -- Content must be empty (a single empty line)
        local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
        if not (#lines == 1 and lines[1] == "") then return end

        -- Don't spam: only one window, and only if nothing else is going on
        if #vim.api.nvim_list_wins() > 1 then return end

        -- Defer so we don't fight with other BufEnter handlers / startup
        vim.schedule(function()
            -- Re-check: user may have moved on
            if vim.api.nvim_get_current_buf() ~= buf then return end
            if #vim.api.nvim_list_wins() > 1 then return end

            require("fzf-lua").files()
        end)
    end,
})
