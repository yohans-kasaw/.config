vim.g.mapleader = " "

require("user.options")
require("user.core")

-- vim.cmd("colorscheme kanso-zen")
vim.cmd("colorscheme kanagawa-wave")

vim.lsp.enable({
	"lua_ls",
	"ts_ls",
	"vue_ls",
	"tailwind",
	"cssls",
	"jsonls",
	"gopls"
})

vim.diagnostic.config({
	float = {
		border = "double",
		source = true,
	},
})
