return {
	plugins = {
		{
			{ "wakatime/vim-wakatime", lazy = false },
		},
		{
			"epwalsh/obsidian.nvim",
			lazy = true,
			ft = "markdown",
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
	keys = function() end,
}
