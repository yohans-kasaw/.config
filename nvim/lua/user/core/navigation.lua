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
		{ "kelly-lin/ranger.nvim", lazy = true },
		{
			"chentoast/marks.nvim",
			event = "VeryLazy",
			lazy = true,
			opts = {
				mappings = {
					set_next = "ma",
					next = "mn",
					preview = "mp",
				},
			},
		},
		{ "aaronik/treewalker.nvim" },
		{
			"ggandor/leap.nvim",
			config = function()
				require("leap").setup({
					safe_labels = {},
					preview_filter = function()
						return false
					end,
				})
			end,
		},
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

		vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap)")
		vim.keymap.set({ "n", "x", "o" }, "gs", function()
			require("leap.remote").action()
		end)

		vim.keymap.set({ "n", "v" }, "<Down>", "<C-f>", { noremap = true, silent = false })
		vim.keymap.set({ "n", "v" }, "<Up>", "<C-b>", { noremap = true, silent = false })

		vim.keymap.set({ "n", "v" }, "<S-Up>", "<cmd>Treewalker Up<cr>", { silent = true })
		vim.keymap.set({ "n", "v" }, "<S-Down>", "<cmd>Treewalker Down<cr>", { silent = true })
		vim.keymap.set({ "n", "v" }, "<S-Left>", "<cmd>Treewalker Left<cr>", { silent = true })
		vim.keymap.set({ "n", "v" }, "<S-Right>", "<cmd>Treewalker Right<cr>", { silent = true })


		vim.api.nvim_set_keymap("n", "<leader>t", "<cmd>Telescope<CR>", { noremap = true, silent = false })

		vim.keymap.set("n", "<leader>g", require("fzf-lua").live_grep_native, { desc = "Grep" })
		vim.keymap.set({ "n", "x" }, "<leader>w", require("fzf-lua").grep_cword, { desc = "Search word under cursor" })
		vim.keymap.set("n", "<leader>r", require("fzf-lua").resume, { desc = "resume" })

		vim.keymap.set("n", "<leader><space>", require("fzf-lua").files, { desc = "Git Files" })
		vim.keymap.set("n", "<leader>b", require("fzf-lua").buffers, { desc = "buffers" })

		vim.keymap.set("n", "<leader>j", require("fzf-lua").jumps, { desc = "jumps" })
	end,
}
