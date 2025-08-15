return {
	plugins = {
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
					shade_terminals = false,
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
		{
			"chrisgrieser/nvim-various-textobjs",
			event = "VeryLazy",
			opts = {
				keymaps = {
					useDefaults = true,
				},
			},
		},
		{
			"nvimdev/lspsaga.nvim",
			config = function()
				require("lspsaga").setup({
					ui = {
						border = "rounded",
						winblend = 10,
					},
					hover = {
						max_width = 0.5,
					},
					symbol_in_winbar = {
						enable = false,
					},
					finder = {
						left_width = 0.16,
						right_width = 0.5,
					},
					lightbulb = {
						enable = false,
					},
				})
			end,
		},
	},

	keys = function()
		vim.keymap.set("n", "<leader>y", "<cmd>YankBank<CR>", { noremap = true })
		vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { silent = true })
		vim.keymap.set("n", "<leader>t", ":ToggleTerm size=50 direction=vertical<cr>", { silent = true })
		vim.keymap.set("n", "<A-r>", ":TermExec cmd='go run .'<cr>", { silent = true })

		vim.keymap.set("n", "<C-e>", "if err != nil {\n\tfmt.Println(err)\n}<Esc>", { silent = true })
		vim.keymap.set("n", "<c-k>", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
		vim.keymap.set("n", "<C-i>", "<cmd>Lspsaga incoming_calls<CR>", { silent = true })
		vim.keymap.set("n", "<C-o>", "<cmd>Lspsaga outgoing_calls<CR>", { silent = true })
		vim.keymap.set("n", "<C-d>", "<cmd>Lspsaga peek_definition<CR>", { silent = true })
		vim.keymap.set("n", "<C-t>", "<cmd>Lspsaga peek_type_definition<CR>", { silent = true })
		vim.keymap.set("n", "<C-u>", "<cmd>Lspsaga outline<CR>", { silent = true })
		vim.keymap.set("n", "<C-f>", "<cmd>Lspsaga finder<CR>", { silent = true })
	end,
}
