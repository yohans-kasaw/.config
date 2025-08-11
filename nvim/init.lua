vim.g.mapleader = " "

require("user.options")
require("user.core")

vim.cmd("colorscheme kanso-zen")
vim.cmd("colorscheme kanso-ink")
-- vim.cmd("colorscheme kanso-pearl")

vim.lsp.enable({
	"lua_ls",
	"ts_ls",
	"vue_ls",
	"tailwind",
	"cssls",
	"jsonls",
	"gopls",
})

vim.diagnostic.config({
	float = {
		border = "double",
		source = true,
	},
})

vim.cmd [[autocmd VimEnter * lua require('fzf-lua').files()]]
