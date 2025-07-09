return {
	plugins = {
		{
			"hrsh7th/nvim-cmp",
			event = "InsertEnter",
			config = function()
				local cmp = require("cmp")
				local cmp_mapping = require("cmp.config.mapping")
				local cmp_autopairs = require("nvim-autopairs.completion.cmp")
				local lspkind = require("lspkind")

				cmp.setup({
					snippet = {
						expand = function(args)
							require("luasnip").lsp_expand(args.body)
						end,
					},
					sources = cmp.config.sources({
						{ name = "luasnip", group_index = 1 },
						{ name = "nvim_lsp", group_index = 2 },
						{ name = "treesitter", group_index = 3 },
						{ name = "nvim_lua", group_index = 4 },
						{ name = "path", group_index = 5 },
						{ name = "buffer", group_index = 6 },
					}),
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
					formatting = {
						format = lspkind.cmp_format({
							mode = "symbol",
							ellipsis_char = "...",
							menu = {
								nvim_lsp = "[lsp]",
								nvim_lua = "[lua]",
								buffer = "[buf]",
								path = "[path]",
								treesitter = "[tree]",
							},
						}),
					},

					mapping = cmp.mapping.preset.insert({
						["<Tab>"] = cmp_mapping(function(fb)
							if cmp.visible() then
								cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
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
						["<CR>"] = cmp_mapping(function(fb)
							if cmp.visible() and cmp.get_selected_entry() then
								cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
							else
								fb()
							end
						end, { "i", "s" }),
					}),
				})
				cmp.setup.filetype("markdown", { enabled = false })
				cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
			end,
			dependencies = {
				{ "hrsh7th/cmp-nvim-lsp" },
				{ "hrsh7th/cmp-buffer" },
				{ "hrsh7th/cmp-path" },
				{ "ray-x/cmp-treesitter" },
				{ "hrsh7th/cmp-nvim-lua" },
				{ "onsails/lspkind.nvim" },
				{ "saadparwaiz1/cmp_luasnip" },
			},
		},

		{
			"L3MON4D3/LuaSnip",
			build = "make install_jsregexp",
			dependencies = { "rafamadriz/friendly-snippets" },
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
			end,
		},
		{
			"hrsh7th/cmp-cmdline",
			event = "CmdlineEnter",
			config = function()
				local cmp = require("cmp")
				cmp.setup.cmdline({ "/", "?" }, {
					mapping = cmp.mapping.preset.cmdline(),
					sources = cmp.config.sources({
						{ name = "buffer" },
						{ name = "path" },
					}),
				})
				cmp.setup.cmdline(":", {
					mapping = cmp.mapping.preset.cmdline(),
					sources = cmp.config.sources({
						{ name = "path" },
						{ name = "cmdline" },
					}),
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
		{ "HiPhish/rainbow-delimiters.nvim" },
		{
			"nvim-treesitter/nvim-treesitter",
			build = ":TSUpdate",
			event = { "BufReadPre" },
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
			event = { "BufReadPre", "BufNewFile" },
			config = function()
				require("nvim-ts-autotag").setup()
			end,
		},
		{ "microsoft/python-type-stubs", lazy = true },
		{
			"JoosepAlviste/nvim-ts-context-commentstring",
			config = function()
				require("ts_context_commentstring").setup({
					enable_autocmd = false,
				})
				local orginal_get_option = vim.filetype.get_option
				vim.filetype.get_option = function(filetype, option)
					return option == "commentstring"
							and require("ts_context_commentstring.internal").calculate_commentstring()
						or orginal_get_option(filetype, option)
				end
			end,
		},
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
