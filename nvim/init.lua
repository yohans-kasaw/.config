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

-- autocmd
vim.cmd([[autocmd VimEnter * lua require('fzf-lua').files()]])

-- Highlights
vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" })
