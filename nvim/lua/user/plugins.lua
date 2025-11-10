return {
	{ "nvim-lua/plenary.nvim" },
	{ "nvim-tree/nvim-web-devicons" },
	{ "wakatime/vim-wakatime" },
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		config = function()
			local cmp = require("cmp")
			local cmp_mapping = require("cmp.config.mapping")
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local lspkind = require("lspkind")

			cmp.setup({
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "treesitter" },
					{ name = "nvim_lua" },
					{ name = "path" },
					{ name = "buffer" },
					{ name = "go_pkgs" },
				}),
				sorting = {
					comparators = {
						cmp.config.compare.score,
						cmp.config.compare.kind,
						cmp.config.compare.order,
					},
				},
				window = {
					completion = cmp.config.window.bordered({ scrollbar = false }),
					documentation = cmp.config.window.bordered({ scrollbar = false }),
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
							go_pkgs = "[pkgs]",
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
				matching = { disallow_symbol_nonprefix_matching = false },
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
			{ "Snikimonkd/cmp-go-pkgs" },
		},
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
		"nvimdev/lspsaga.nvim",
		config = function()
			require("lspsaga").setup({
				ui = {
					border = "rounded",
				},
				hover = {
					max_width = 0.5,
				},
				symbol_in_winbar = {
					enable = true,
				},
				finder = {
					left_width = 0.16,
					right_width = 0.5,
				},
				lightbulb = {
					enable = false,
				},
			})
		end,
	},
	{
		"Wansmer/treesj",
		config = function()
			require("treesj").setup({
				use_default_keymaps = false,
				max_join_length = 420,
			})
		end,
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		config = function()
			require("ts_context_commentstring").setup({
				enable_autocmd = false,
			})
			local org_get_option = vim.filetype.get_option
			vim.filetype.get_option = function(filetype, option)
				return option == "commentstring"
						and require("ts_context_commentstring.internal").calculate_commentstring()
					or org_get_option(filetype, option)
			end
		end,
	},
	{
		"chrisgrieser/nvim-spider",
		keys = {
			{ "w", "<cmd>lua require('spider').motion('w')<CR>", mode = { "n", "v", "x" } },
			{ "e", "<cmd>lua require('spider').motion('e')<CR>", mode = { "n", "v", "x" } },
			{ "b", "<cmd>lua require('spider').motion('b')<CR>", mode = { "n", "v", "x" } },
		},
		config = function()
			require("spider").setup({ skipInsignificantPunctuation = false })
		end,
	},
	{
		"kylechui/nvim-surround",
		version = "*",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup()
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},
	{ "HiPhish/rainbow-delimiters.nvim" },
	{
		"mcauley-penney/visual-whitespace.nvim",
		config = true,
		event = "ModeChanged *:[vV\22]",
		opts = {},
	},
	{
		"xiyaowong/transparent.nvim",
		config = function()
			require("transparent").setup({
				exclude_groups = { "CursorLine" },
			})
		end,
	},
	{
		"yamatsum/nvim-cursorline",
		config = function()
			require("nvim-cursorline").setup({
				cursorline = { enable = false },
				cursorword = { enable = true, min_length = 3, hl = { underline = true } },
			})
		end,
	},
	{
		"m4xshen/smartcolumn.nvim",
		opts = {},
	},
	{
		"stevearc/conform.nvim",
		cmd = { "ConformInfo" },
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					css = { "prettier" },
					go = { "gofmt" },
					html = { "prettier" },
					javascript = { "prettier" },
					javascriptreact = { "prettier" },
					json = { "prettier" },
					lua = { "stylua" },
					python = { "black" },
					typescript = { "prettier" },
					typescriptreact = { "prettier" },
					vue = { "prettier" },
					yaml = { "prettier" },
				},
				formatters = {
					black = {
						prepend_args = {
							"--skip-string-normalization",
							"--skip-magic-trailing-comma",
						},
					},
					gofmt = {
						prepend_args = { "-s" },
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
	{
		"ibhagwan/fzf-lua",
		config = function()
			require("fzf-lua").setup({
				fzf_opts = { ["--layout"] = "reverse-list" },
				winopts = { fullscreen = true },
				keymap = { fzf = { ["ctrl-q"] = "select-all+accept" } },
			})
		end,
	},
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		opts = {},
	},
	{
		"folke/which-key.nvim",
		opts = { preset = "helix", delay = 800 },
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				insert_mappings = true,
				shade_terminals = false,
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPre" },
		config = function()
			local configs = require("nvim-treesitter.configs")
			configs.setup({
				auto_install = true,
				highlight = { enable = true },
				indent = { enable = true, disable = { "markdown" } },
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<CR>",
						node_incremental = "<CR>",
						node_decremental = "<S-CR>",
					},
				},
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["af"] = "@function.outer",
							["ac"] = "@class.outer",
							["if"] = "@function.inner",
							["ic"] = "@class.inner",
						},
					},
				},
			})
		end,
		dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
	},

	{
		"chrisgrieser/nvim-various-textobjs",
		opts = { keymaps = { useDefaults = true } },
	},
	{
		"folke/noice.nvim",
		opts = {
			top_down = false,
			presets = {
				bottom_search = true,
				command_palette = true,
			},
			lsp = {
				progress = {
					enabled = false,
				},
			},
		},
	},
	{
		"nvim-tree/nvim-tree.lua",
		config = function()
			require("nvim-tree").setup({
				view = { side = "right" },
				renderer = {
					full_name = true,
					group_empty = true,
					indent_markers = { enable = true },
					icons = {
						git_placement = "signcolumn",
						show = { folder = false },
					},
				},
				diagnostics = { enable = true, show_on_dirs = true },
				update_focused_file = { enable = true },
				filters = { custom = { "^.git$" } },
			})
		end,
	},
	{ "webhooked/kanso.nvim", priority = 1000 },
	{
		"ggandor/leap.nvim",
		config = function()
			require("leap").setup({
				safe_labels = {},
				preview_filter = function()
					return false
				end,
				on_beacons = function(targets)
					for _, t in ipairs(targets) do
						if t.label and t.beacon then
							t.beacon[1] = 0
						end
					end
					return true
				end,
			})
		end,
	},
	{ "aaronik/treewalker.nvim" },
	{
		"stevearc/oil.nvim",
		opts = {
			float = {
				padding = 0,
				max_width = 0.98,
				max_height = 0.98,
				get_win_title = function()
					return "oil"
				end,
				preview_split = "right",
			},
			keymaps = {
				["q"] = { "actions.close", mode = "n" },
			},
			view_options = {
				show_hidden = true,
			},
		},
	},
	{
		"nvimtools/none-ls.nvim",
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.goimports,
				},
			})
		end,
	},
	{
		"folke/persistence.nvim",
		config = true,
	},
	{
		"esmuellert/nvim-eslint",
		config = function()
			require("nvim-eslint").setup({})
		end,
	},
	{
		"NeogitOrg/neogit",
	},
	{
		"sindrets/diffview.nvim",
		config = function()
			require("diffview").setup({
				keymaps = {
					view = {
						{ "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" } },
					},
					file_panel = {
						{ "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" } },
					},
					file_history_panel = {
						{ "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" } },
					},
				},
			})
		end,
	},
	{
		"A7lavinraj/assistant.nvim",
		opts = {},
	},
	{
		"m4xshen/hardtime.nvim",
		lazy = false,
		dependencies = { "MunifTanjim/nui.nvim" },
		opts = {
			disabled_keys = {
				["<Up>"] = false,
				["<Down>"] = false,
			},
		},
	},
	-- {
	-- 	"supermaven-inc/supermaven-nvim",
	-- 	config = function()
	-- 		require("supermaven-nvim").setup({
	-- 			ignore_filetypes = { "markdown" },
	-- 			keymaps = {
	-- 				accept_suggestion = "<A-S-Space>",
	-- 				clear_suggestion = "<A-BS>",
	-- 				accept_word = "<A-Space>",
	-- 			},
	-- 		})
	-- 	end,
	-- },
	{
		"romus204/go-tagger.nvim",
		config = function()
			require("go-tagger").setup({
				skip_private = true, -- Skip unexported fields (starting with lowercase)
			})
		end,
	},
	{
		"maxandron/goplements.nvim",
		ft = "go",
		opts = {
			prefix = {
				interface = "//Implemented by: ",
				struct = "//Implements: ",
			},
			highlight = "Comment",
		},
	},
	{ "nvim-telescope/telescope.nvim" },
	{
		"fredrikaverpil/godoc.nvim",
		version = "*",
		build = "go install github.com/lotusirous/gostdsym/stdsym@latest",
		cmd = { "GoDoc" },
		opts = {
			window = {
				type = "vsplit",
			},
			picker = {
				type = "fzf_lua",
				fzf_lua = {},
			},
		},
	},
	{
		"edolphin-ydf/goimpl.nvim",
		config = function()
			require("telescope").load_extension("goimpl")
		end,
	},
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"leoluz/nvim-dap-go",
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			require("dapui").setup({})
			require("dap-go").setup({})
			require("nvim-dap-virtual-text").setup({})

			local dap = require("dap")
			local dapui = require("dapui")

			dap.listeners.after.attach.dapui_config = function()
				dapui.open()
			end

			dap.listeners.after.launch.dapui_config = function()
				dapui.open()
			end

			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end

			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end
		end,
	},
	{
		"chentoast/marks.nvim",
		event = "VeryLazy",
		opts = {
			mappings = {
				next = "<C-S-Down>",
				prev = "<C-S-Up>",
				toggle = "m,",
				set = false,
				preview = false,
				set_next = false,
			},
		},
	},
	{
		"XXiaoA/atone.nvim",
		cmd = "Atone",
		opts = {
			layout = {
				direction = "left",
				width = 0.99,
			},
			diff_cur_node = {
				enabled = true,
				split_percent = 0.5,
			},
			ui = {
				border = "rounded",
			},
		},
	},
	{
		"nvim-mini/mini.diff",
		version = false,
		config = function()
			require("mini.diff").setup()
		end,
	},
}
