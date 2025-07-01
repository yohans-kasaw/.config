return {
	init_options = {
		hostInfo = "neovim",
	},
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
		"typescript",
	},
	root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
}
