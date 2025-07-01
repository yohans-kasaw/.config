return {
	plugins = {
		{
			"nvim-telescope/telescope.nvim",
			dependencies = { "nvim-lua/plenary.nvim" },
		},
		{
			"folke/snacks.nvim",
			priority = 1000,
			lazy = false,
			opts = {
				bigfile = { enabled = true },
				dashboard = {
					sections = {
						{
							section = "projects",
							title = "projects",
							icon = "",
							indent = 2,
							padding = 1,
						},
						{ section = "session" },
						{ section = "startup" },
					},
				},
				indent = { enabled = true },
				notify = { enabled = true },
			},
		},
		{
			"ibhagwan/fzf-lua",
			dependencies = { "nvim-tree/nvim-web-devicons" },
			opts = {},
		},
	},
	keys = function()
		vim.api.nvim_set_keymap("n", "<leader>t", "<cmd>Telescope<CR>", { noremap = true, silent = false })

		vim.keymap.set("n", "<leader>/", require("fzf-lua").grep, { desc = "Grep" })
		vim.keymap.set({ "n", "x" }, "<leader>w", require("fzf-lua").grep_cword, { desc = "Search word under cursor" })

		vim.keymap.set("n", "<leader><space>", require("fzf-lua").git_files, { desc = "Git Files" })
		vim.keymap.set("n", "<leader>j", require("fzf-lua").jumps, { desc = "jumps" })
	end,
}
