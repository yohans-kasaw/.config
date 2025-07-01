return {
	plugins = {
		{
			"pmizio/typescript-tools.nvim",
			dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
			opts = {},
		},
		{
			"epwalsh/obsidian.nvim",
			config = function()
				require("obsidian").setup({

					workspaces = {
						{
							name = "saga",
							path = "~/obsidian/saga",
						},
					},
				})
			end,
		},
	},
	keys = function()
	end,
}
