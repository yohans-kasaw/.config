return {
	plugins = {
		{
			"nvim-telescope/telescope.nvim",
			dependencies = { "nvim-lua/plenary.nvim" },
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
