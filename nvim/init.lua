vim.g.mapleader = " "

require("user.options")
require("user.core")

-- vim.cmd("colorscheme kanso-zen")
-- vim.cmd("colorscheme kanagawa-wave")

vim.g.sonokai_style = 'espresso'
vim.cmd.colorscheme("sonokai")

vim.lsp.enable({
	"lua_ls",
	"ts_ls",
	"vue_ls",
	"tailwind",
	"cssls",
	"jsonls",
	"gopls",
	"hyprlang"
})

vim.diagnostic.config({
	float = {
		border = "double",
		source = true,
	},
})

vim.filetype.add({
  pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
})
