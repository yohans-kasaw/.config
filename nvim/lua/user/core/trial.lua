return {
	plugins = {
		{
			{ "wakatime/vim-wakatime", lazy = false },
		},
		{
			"lowitea/aw-watcher.nvim",
			opts = {
				aw_server = {
					host = "127.0.0.1",
					port = 5600,
				},
			},
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
