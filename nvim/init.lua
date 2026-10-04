require("config.lazy")
require("user.options")
require("user.binding")
require("user.commands")
require("user.autocmd")

vim.lsp.enable({
    "basedpyright",
    "tailwind",
    "typescript",
})
