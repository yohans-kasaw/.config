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

-- auto cmd
vim.cmd("autocmd CursorMoved * normal! zz")
vim.api.nvim_create_autocmd("CursorMovedI", {
	pattern = "*",
	group = vim.api.nvim_create_augroup("center", { clear = true }),
	callback = function()
		local pos = vim.fn.getpos(".")
		vim.cmd("normal! zz")
		vim.fn.setpos(".", pos)
	end,
})

vim.api.nvim_create_autocmd("VimEnter", {
	nested = true,
	group = vim.api.nvim_create_augroup("persistence", { clear = true }),
	callback = function()
		require("persistence").load()
	end,
})

-- Highlights
vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" })
