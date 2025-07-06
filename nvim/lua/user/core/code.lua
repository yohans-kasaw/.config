return {
	plugins = {
		{ "onsails/lspkind.nvim" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/cmp-buffer" },
		{ "hrsh7th/cmp-path" },
		{ "hrsh7th/cmp-cmdline" },
		{
			"hrsh7th/nvim-cmp",
			config = function()
				local cmp = require("cmp")
				local cmp_mapping = require("cmp.config.mapping")

				local custom_mapping = cmp.mapping.preset.insert({
					["<Tab>"] = cmp_mapping(function(fb)
						if cmp.visible() then
							cmp.select_next_item()
						else
							fb()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp_mapping(function(fb)
						if cmp.visible() then
							cmp.select_prev_item()
						else
							fb()
						end
					end, { "i", "s" }),
					["<C-Space>"] = cmp_mapping.complete(),
					["<CR>"] = cmp_mapping(function(fb)
						if cmp.visible() and cmp.get_selected_entry() then
							cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
						else
							fb()
						end
					end, { "i", "s" }),
				})

				cmp.setup({
					mapping = custom_mapping,
					sorting = {
						comparators = {
							cmp.config.compare.score,
							cmp.config.compare.order,
							cmp.config.compare.kind,
						},
					},
					window = {
						completion = cmp.config.window.bordered({
							scrollbar = false,
						}),

						documentation = cmp.config.window.bordered({
							scrollbar = false,
						}),
					},

					sources = cmp.config.sources({
						{ name = "nvim_lsp" },
						{ name = "buffer" },
						{ name = "path" },
						{ name = "treesitter" },
					}),
				})

				cmp.setup.cmdline({ "/", "?" }, {
					mapping = custom_mapping,
					sources = cmp.config.sources({
						{ name = "buffer" },
						{ name = "path" },
					}),
				})

				cmp.setup.cmdline(":", {
					mapping = custom_mapping,
					sources = cmp.config.sources({
						{ name = "path" },
						{ name = "cmdline" },
					}),
				})

				cmp.setup.filetype("markdown", {
					enabled = false,
				})
			end,
		},
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
