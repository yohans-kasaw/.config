require("config.lazy")
require("user.options")
require("user.keymaps")
require("user.commands")
require("user.autocmd")

vim.lsp.enable({
    "basedpyright",
    "svelte",
    "tailwind",
    "typescript",
})
