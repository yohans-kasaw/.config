vim.g.mapleader = " "

require("user.options")
require("user.core")
require("user.cmp")

vim.cmd("colorscheme kanso-zen")

vim.lsp.enable({
	"lua_ls",
	"ts_ls",
	-- "volar",
})

vim.diagnostic.config({
	float = {
		border = "double",
		source = true,
	},
})
