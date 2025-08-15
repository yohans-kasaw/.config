local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(require("user.plugin"))
require("user.options")
require("user.binding")

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
