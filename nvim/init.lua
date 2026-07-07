require("config.lazy")
require("user.options")
require("user.keymaps")
require("user.commands")
require("user.autocmd")

vim.lsp.enable({
    "basedpyright",
    "svelte",
    "tailwind"
})

vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("restore_session", { clear = true }),
    callback = function()
        local is_not_home = vim.fn.getcwd() ~= vim.env.HOME
        local no_file_args = vim.fn.argc() == 0
        local is_git_repo = vim.fn.finddir(".git", vim.fn.getcwd() .. ";") ~= nil

        if no_file_args and is_git_repo and is_not_home then
            require("persistence").load()
        end
    end,
    nested = true,
})

require('mini.pairs').setup({})
