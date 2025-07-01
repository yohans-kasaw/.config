return {
	plugins = {
		{ "hrsh7th/nvim-cmp" },
		{ "onsails/lspkind.nvim" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/cmp-buffer" },
		{ "hrsh7th/cmp-path" },
		{
			"stevearc/conform.nvim",
			cmd = { "ConformInfo" },
			lazy = true,
			config = function()
				require("conform").setup({
					formatters_by_ft = {
						lua = { "stylua" },
						python = { "black" },
						javascript = { "prettier" },
						typescript = { "prettier" },
						javascriptreact = { "prettier" },
						typescriptreact = { "prettier" },
						css = { "prettier" },
						html = { "prettier" },
						json = { "prettier" },
						yaml = { "prettier" },
						vue = { "prettier" },
					},
					formatters = {
						black = {
							prepend_args = {
								"--skip-string-normalization",
								"--skip-magic-trailing-comma",
							},
						},
						prettier = {
							prepend_args = {
								"--tab-width",
								"4",
								"--single-quote",
								"--no-semi",
								"--trailing-comma",
								"all",
							},
						},
					},
				})
			end,
		},
		{ "Bilal2453/luvit-meta" },
		{ "HiPhish/rainbow-delimiters.nvim" },
		{
			"nvim-treesitter/nvim-treesitter",
			build = ":TSUpdate",
			config = function()
				local configs = require("nvim-treesitter.configs")
				configs.setup({
					modules = {},
					ignore_install = {},
					ensure_installed = "all",
					sync_install = true,
					auto_install = true,
					highlight = { enable = true },
					indent = {
						enable = true,
						disable = { "markdown" },
					},
					incremental_selection = {
						enable = true,
						keymaps = {
							init_selection = "<CR>",
							node_incremental = "<CR>",
						},
					},
				})
			end,
		},
		{
			"windwp/nvim-autopairs",
			config = function()
				require("nvim-autopairs").setup()
			end,
		},
		{
			"kylechui/nvim-surround",
			version = "*",
			event = "VeryLazy",
			config = function()
				require("nvim-surround").setup({})
			end,
		},
		{
			"Wansmer/treesj",
			config = function()
				require("treesj").setup({})
			end,
		},
		{
			"windwp/nvim-ts-autotag",
			config = function()
				require("nvim-ts-autotag").setup()
			end,
		},
		{ "microsoft/python-type-stubs", lazy = true },
	},
	keys = function()
		vim.keymap.set("n", "gl", function()
			vim.diagnostic.open_float(nil, {})
		end, { noremap = true, silent = true, desc = "Show Line Diagnostics" })

		vim.keymap.set({ "n", "v" }, "<leader>ff", function()
			require("conform").format({
				lsp_fallback = false,
				async = false,
				timeout_ms = 500,
			})
		end, {
			desc = "Format file or range (in visual mode)",
		})
	end,
}
