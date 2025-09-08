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


vim.api.nvim_create_autocmd("VimEnter", {
	nested = true,
	group = vim.api.nvim_create_augroup("persistence", { clear = true }),
	callback = function()
		require("persistence").load()
	end,
})

vim.api.nvim_create_autocmd("VimEnter", {
	group = vim.api.nvim_create_augroup("restore_session", { clear = true }),
	callback = function()
        local is_not_home = vim.fn.getcwd() ~= vim.env.HOME
        local no_file_args = vim.fn.argc() == 0
        local is_not_git_repo = vim.fn.finddir(".git", vim.fn.getcwd() .. ";") == nil

        if is_not_home and no_file_args and is_not_git_repo then
            require("persistence").load()
        end
	end,
	nested = true,
})
-- Highlights
vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" })
