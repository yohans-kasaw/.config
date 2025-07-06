return {
	plugins = {
		{
			"folke/noice.nvim",
			lazy = true,
			event = "VeryLazy",
			opts = {
				top_down = false,
			},
			dependencies = {
				"MunifTanjim/nui.nvim",
			},
		},
		{
			"nvim-tree/nvim-tree.lua",
			config = function()
				require("nvim-tree").setup({
					view = {
						side = "right",
					},

					renderer = {
						full_name = true,
						group_empty = true,
						indent_markers = {
							enable = true,
						},
						icons = {
							git_placement = "signcolumn",
							show = {
								folder = false,
							},
						},
					},
					diagnostics = {
						enable = true,
						show_on_dirs = true,
					},
					update_focused_file = {
						enable = true,
					},
					filters = {
						custom = {
							"^.git$",
						},
					},
				})
			end,
		},
		{
			"folke/zen-mode.nvim",
			lazy = true,
		},
		{
			"nvim-tree/nvim-web-devicons",
		},
		{
			"yamatsum/nvim-cursorline",
			config = function()
				require("nvim-cursorline").setup({
					cursorline = {
						enable = true,
						timeout = 1000,
						number = false,
					},
					cursorword = {
						enable = true,
						min_length = 3,
						hl = { underline = true },
					},
				})
			end,
		},
		{
			"nvimdev/dashboard-nvim",
			event = "VimEnter",
			config = function()
				require("dashboard").setup({})
			end,
			dependencies = { { "nvim-tree/nvim-web-devicons" } },
		},
		{
			"m4xshen/smartcolumn.nvim",
			opts = {},
		},
		{
			"webhooked/kanso.nvim",
			priority = 1000,
		},
		{
			"mcauley-penney/visual-whitespace.nvim",
			lazy = true,
			config = true,
			event = "ModeChanged *:[vV\22]",
			opts = {},
		},
	},
	keys = function()
		vim.api.nvim_set_keymap("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
	end,
}
