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
	"user.ui",
	"user.msc",
	"user.code",
	"user.motion",
	"user.git",
	"user.trial",
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

local null_ls = require("null-ls")

local no_really = {
	method = null_ls.methods.DIAGNOSTICS,
	filetypes = { "markdown", "text" },
	generator = {
		fn = function(params)
			local diagnostics = {}
			-- sources have access to a params object
			-- containing info about the current file and editor state
			for i, line in ipairs(params.content) do
				local col, end_col = line:find("really")
				if col and end_col then
					-- null-ls fills in undefined positions
					-- and converts source diagnostics into the required format
					table.insert(diagnostics, {
						row = i,
						col = col,
						end_col = end_col + 1,
						source = "no-really",
						message = "Don't use 'really!'",
						severity = vim.diagnostic.severity.WARN,
					})
				end
			end
			return diagnostics
		end,
	},
}

null_ls.register(no_really)
