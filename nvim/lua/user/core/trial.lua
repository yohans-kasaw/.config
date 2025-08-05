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
		{
			"jiaoshijie/undotree",
			dependencies = "nvim-lua/plenary.nvim",
			config = function()
				require("undotree").setup({
					float_diff = false,
					position = "right",
				})
			end,
		},
		{
			"nvimtools/none-ls.nvim",
			config = function()
				local null_ls = require("null-ls")

				null_ls.setup({
					sources = {
						null_ls.builtins.formatting.stylua,
						null_ls.builtins.completion.spell,
						-- require("none-ls.diagnostics.eslint"), -- requires none-ls-extras.nvim
					},
				})
			end,
		},
	},
	keys = function()
		vim.keymap.set("n", "<leader>u", "<cmd>lua require('undotree').toggle()<cr>", { desc = "undo tree" })
		vim.keymap.set("n", "<leader>y", "<cmd>YankBank<CR>", { noremap = true })
		vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { silent = true })
		vim.keymap.set("n", "<leader>t", ":ToggleTerm size=50 direction=vertical<cr>", { silent = true })
	end,
}
