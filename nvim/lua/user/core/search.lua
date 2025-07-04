return {
	plugins = {
		{
			"nvim-telescope/telescope.nvim",
			dependencies = { "nvim-lua/plenary.nvim" },
		},
		{
			"ibhagwan/fzf-lua",
			dependencies = { "nvim-tree/nvim-web-devicons" },
			config = function()
				require("fzf-lua").setup({
					winopts = {
						height = 0.95,
						row = 0.50,
						preview = {
							vertical = "down:70%",
							layout = "vertical",
							title = false,
							scrollbar = false,
							wrap = true,
						},
					},
				})
			end,
		},
	},
	keys = function()
		vim.api.nvim_set_keymap("n", "<leader>t", "<cmd>Telescope<CR>", { noremap = true, silent = false })

		vim.keymap.set("n", "<leader>g", require("fzf-lua").live_grep_native, { desc = "Grep" })
		vim.keymap.set({ "n", "x" }, "<leader>w", require("fzf-lua").grep_cword, { desc = "Search word under cursor" })
		vim.keymap.set("n", "<leader>rg", require("fzf-lua").live_grep_resume, { desc = "resume" })

		vim.keymap.set("n", "<leader><space>", require("fzf-lua").files, { desc = "Git Files" })
		vim.keymap.set("n", "<leader>b", require("fzf-lua").buffers, { desc = "buffers" })

		vim.keymap.set("n", "<leader>j", require("fzf-lua").jumps, { desc = "jumps" })
	end,
}
