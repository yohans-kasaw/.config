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
		{
			"akinsho/toggleterm.nvim",
			version = "*",

			config = function()
				require("toggleterm").setup({
					insert_mappings = true,
					-- autochdir = true,
				})
			end,
		},
	},
	keys = function()
		vim.keymap.set("n", "<leader>y", "<cmd>YankBank<CR>", { noremap = true })
		vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

		-- keyset("n", "<space><space>", ":ToggleTerm size=15<cr>", { silent = true })
		vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { silent = true })
		vim.keymap.set("n", "<leader>t", ":ToggleTerm size=50 direction=vertical<cr>", { silent = true })
	end,
}
