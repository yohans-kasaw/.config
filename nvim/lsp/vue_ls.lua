return {
	cmd = { "vue-language-server", "--stdio" },
	filetypes = { "vue" },
	root_markers = { "package.json" },
	init_options = {
		vue = {
			hybridMode = false,
		},
		typescript = {
			tsdk = "/usr/lib/node_modules/typescript/lib/",
		},
	},
}
