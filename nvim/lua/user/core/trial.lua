return {
	plugins = {
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
			"stevearc/oil.nvim",
			opts = {},
			dependencies = { { "echasnovski/mini.icons", opts = {} } },
			lazy = false,
			config = function()
				require("oil").setup()
			end,
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
        vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
	end,
}
