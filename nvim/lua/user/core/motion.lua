return {
	plugins = {
		{ "kelly-lin/ranger.nvim", lazy = true },
		{ "aaronik/treewalker.nvim" },
		{
			"nvim-telescope/telescope.nvim",
			dependencies = { "nvim-lua/plenary.nvim" },
		},
		{
			"ThePrimeagen/harpoon",
			config = function()
				require("harpoon").setup({
					tabline = true,
				})
			end,
		},
		{
			"chrisgrieser/nvim-spider",
			lazy = true,
			keys = {
				{ "w", "<cmd>lua require('spider').motion('w')<CR>", mode = { "n" } },
				{ "e", "<cmd>lua require('spider').motion('e')<CR>", mode = { "n" } },
				{ "b", "<cmd>lua require('spider').motion('b')<CR>", mode = { "n" } },
			},
			config = function()
				require("spider").setup({
					skipInsignificantPunctuation = false,
				})
			end,
		},
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
			"ibhagwan/fzf-lua",
			dependencies = { "nvim-tree/nvim-web-devicons" },
			config = function()
				require("fzf-lua").setup({
					fzf_opts = {
						["--layout"] = "reverse-list",
					},
					winopts = {
						fullscreen = true,
					},
					keymap = {
						fzf = {
							["ctrl-q"] = "select-all+accept",
						},
					},
				})
			end,
		},
	},
	keys = function()
		local harpoon = require("harpoon.ui")

		vim.keymap.set("n", "<leader>h", require("harpoon.mark").add_file)
		vim.keymap.set("n", "<leader>l", harpoon.toggle_quick_menu)

		vim.keymap.set("n", "<A-a>", function()
			harpoon.nav_file(1)
		end)
		vim.keymap.set("n", "<A-o>", function()
			harpoon.nav_file(2)
		end)
		vim.keymap.set("n", "<A-e>", function()
			harpoon.nav_file(3)
		end)
		vim.keymap.set("n", "<A-u>", function()
			harpoon.nav_file(4)
		end)
		vim.keymap.set("n", "<A-i>", function()
			harpoon.nav_file(5)
		end)
		vim.keymap.set("n", "<A-6>", function()
			harpoon.nav_file(6)
		end)

		vim.keymap.set("n", "<A-7>", function()
			harpoon.nav_file(7)
		end)
		vim.keymap.set("n", "<A-8>", function()
			harpoon.nav_file(8)
		end)

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

		vim.keymap.set({ "n", "v" }, "<S-Up>", "<cmd>Treewalker Up<cr>zz", { silent = true })
		vim.keymap.set({ "n", "v" }, "<S-Down>", "<cmd>Treewalker Down<cr>zz", { silent = true })
		vim.keymap.set({ "n", "v" }, "<S-Left>", "<cmd>Treewalker Left<cr>zz", { silent = true })
		vim.keymap.set({ "n", "v" }, "<S-Right>", "<cmd>Treewalker Right<cr>zz", { silent = true })

		vim.api.nvim_set_keymap("n", "<leader>t", "<cmd>Telescope<CR>", { noremap = true, silent = false })

		vim.keymap.set("n", "<leader>r", require("fzf-lua").resume, { desc = "resume" })
		vim.keymap.set("n", "<leader>g", require("fzf-lua").live_grep_native, { desc = "Grep" })
		vim.keymap.set({ "n", "x" }, "<leader>w", require("fzf-lua").grep_cword, { desc = "Search word under cursor" })
		vim.keymap.set("n", "<leader><space>", require("fzf-lua").files, { desc = "Files" })
		vim.keymap.set("n", "<leader>b", require("fzf-lua").buffers, { desc = "buffers" })
	end,
}
