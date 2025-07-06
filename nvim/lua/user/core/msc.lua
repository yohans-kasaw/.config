return {
	plugins = {
		{
			"folke/persistence.nvim",
			event = "BufReadPre",
			opts = {},
		},
		{
			"folke/which-key.nvim",
			event = "VeryLazy",
			opts = {
				preset = "modern",
			},
			init = function()
				vim.o.timeout = true
				vim.o.timeoutlen = 300
			end,
		},
	},
	keys = function()
		vim.api.nvim_set_keymap("n", "<C-n>", "<Cmd>noh<CR>", { noremap = true, silent = false })
		vim.keymap.set("n", "Q", "@q", { noremap = true, desc = "Easy repeating of macro saved to q register" })
		vim.api.nvim_set_keymap("n", "<leader>o", ":w<CR>", { noremap = true, silent = true })
		vim.keymap.set({ "n", "x" }, "<leader>d", '"_d', { noremap = true, desc = "Deletes to black hole register" })

		vim.keymap.set({ "n", "v", "o" }, "H", "0", { noremap = true })
		vim.keymap.set({ "n", "v", "o" }, "L", "$", { noremap = true })

		vim.keymap.set("n", "<leader>s", function()
			require("persistence").load()
		end, { desc = "select a session to load" })
	end,
}
