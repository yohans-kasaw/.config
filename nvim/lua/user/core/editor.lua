return {
	plugins = {
		{
			"mcauley-penney/visual-whitespace.nvim",
			lazy = true,
			config = true,
			event = "ModeChanged *:[vV\22]",
			opts = {},
		},
	},
	keys = function() end,
}
