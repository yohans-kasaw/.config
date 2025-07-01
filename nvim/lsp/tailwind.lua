return {
	cmd = { "tailwindcss-language-server", "--stdio" },
	filetypes = {
		"html",
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"vue",
	},
	settings = {
		tailwindCSS = {
			validate = true,
			lint = {
				cssConflict = "warning",
				invalidApply = "error",
				invalidScreen = "error",
				invalidVariant = "error",
				invalidConfigPath = "error",
				invalidTailwindDirective = "error",
				recommendedVariantOrder = "warning",
			},
			classAttributes = {
				"class",
				"className",
			},
		},
	},
	root_markers = {
		".git",
		"postcss.config.js",
		"postcss.config.cjs",
		"postcss.config.mjs",
		"postcss.config.ts",
	},
}
