return {
	plugins = {
		{
			"tummetott/reticle.nvim",
			event = "VeryLazy",
			opts = {
				on_startup = {
					cursorline = true,
					cursorcolumn = true,
				},
			},
		},
        {"xiyaowong/transparent.nvim"},
		{
			"otavioschwanck/arrow.nvim",
			opts = {
				buffer_leader_key = "m",
				leader_key = "<leader>;",
				mappings = {
					next_item = "h",
					prev_item = "n",
				},
			},
		},
		{
			"ptdewey/yankbank-nvim",
			dependencies = "kkharji/sqlite.lua",
			config = function()
				require("yankbank").setup({
					persist_type = "sqlite",
				})
			end,
		},
	},
	keys = function()
		vim.keymap.set("n", "<leader>y", "<cmd>YankBank<CR>", { noremap = true })
	end,
}
