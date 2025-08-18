local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("user.options")
require("lazy").setup({
	spec = require("user.plugins"),
})
require("user.keymaps")
vim.opt.statusline = "%!v:lua.get_grapple_status()"
require("user.functions")

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
	"pylsp",
})

vim.diagnostic.config({
	float = {
		border = "double",
		source = true,
	},
})

-- autocmd
-- vim.cmd([[autocmd VimEnter * lua require('fzf-lua').files()]])
-- vim.cmd([[autocmd VimEnter * Grapple toggle_tags]])

-- Highlights
vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" })
