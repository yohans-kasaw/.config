return {
	plugins = {
		{
			"pmizio/typescript-tools.nvim",
			dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
			opts = {},
		},
		{
			"echasnovski/mini.nvim",
			version = false,
			config = function()
				require("mini.diff").setup()
			end,
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
		vim.keymap.set("n", ";d", MiniDiff.toggle_overlay, { desc = "MiniDiff Toggle" })
		vim.cmd([[cab cc CodeCompanion]])
	end,
}
