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
				preset = "helix",
				delay = 800,
			},
			init = function()
				vim.o.timeout = true
				vim.o.timeoutlen = 300
			end,
		},
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
	keys = function()
		vim.keymap.set("n", "<C-n>", "<Cmd>noh<CR>", { noremap = true, silent = false })
		vim.keymap.set("n", "<leader>o", ":w<CR>", { noremap = true, silent = true })
		vim.keymap.set({ "n", "x" }, "<leader>d", '"_d', { noremap = true, desc = "Deletes to black hole register" })

		vim.keymap.set({ "n", "v", "o" }, "H", "0", { noremap = true })
		vim.keymap.set({ "n", "v", "o" }, "L", "$", { noremap = true })

		vim.keymap.set("n", "<leader>s", function()
			require("persistence").load()
		end, { desc = "select a session to load" })
	end,
}
