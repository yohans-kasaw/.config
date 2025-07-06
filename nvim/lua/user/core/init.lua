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

local modules = {
	"user.core.ui",
	"user.core.msc",
	"user.core.code",
	"user.core.motion",
	"user.core.git",
	"user.core.trial",
}

local plugins = {}
for _, module in ipairs(modules) do
	local module_plugins = require(module).plugins
	if module_plugins then
		for _, plugin in ipairs(module_plugins) do
			table.insert(plugins, plugin)
		end
	end
end

require("lazy").setup(plugins)
-- Apply key mappings
for _, module in ipairs(modules) do
	local module_keys = require(module).keys
	if module_keys then
		module_keys()
	end
end
