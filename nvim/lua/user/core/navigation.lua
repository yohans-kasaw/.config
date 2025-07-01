return {
	plugins = {
		{
			"ThePrimeagen/harpoon",
			config = function()
				require("harpoon").setup({
					tabline = true,
				})
			end,
		},
		{ "kelly-lin/ranger.nvim" },
		{
			"chentoast/marks.nvim",
			event = "VeryLazy",
			opts = {
				mappings = {
					set_next = "ma",
					next = "mn",
					preview = "mp",
				},
			},
		},
	},
	keys = function()
		vim.keymap.set("n", "<leader>h", require("harpoon.mark").add_file, { noremap = true, silent = false })
		vim.keymap.set("n", "<leader>l", require("harpoon.ui").toggle_quick_menu, { noremap = true, silent = false })

		vim.keymap.set("n", "tn", require("harpoon.ui").nav_next, { noremap = true, silent = false })
		vim.keymap.set("n", "th", require("harpoon.ui").nav_prev, { noremap = true, silent = false })

		vim.api.nvim_set_keymap("n", "<leader>bc", "<cmd>bd<CR>", { noremap = true, silent = false })
		vim.keymap.set("n", "<leader>ba", function()
			for _, buf in ipairs(vim.api.nvim_list_bufs()) do
				if buf ~= vim.api.nvim_get_current_buf() then
					vim.api.nvim_buf_delete(buf, { force = false })
				end
			end
		end, { noremap = true, silent = true, desc = "Close Other Buffers (Tab All)" })

		vim.keymap.set("n", "<leader>rr", function()
			require("ranger-nvim").open(true)
		end, { noremap = true, desc = "open ranger" })

		vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
	end,
}
