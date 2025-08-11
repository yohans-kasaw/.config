return {
	plugins = {
		{
			"ptdewey/yankbank-nvim",
			dependencies = "kkharji/sqlite.lua",
			config = function()
				require("yankbank").setup({
					persist_type = "sqlite",
				})
			end,
		},
		{
			"akinsho/toggleterm.nvim",
			version = "*",

			config = function()
				require("toggleterm").setup({
					insert_mappings = true,
				})
			end,
		},
		{
			"nvimtools/none-ls.nvim",
			config = function()
				local null_ls = require("null-ls")

				null_ls.setup({
					sources = {
						null_ls.builtins.formatting.stylua,
						null_ls.builtins.completion.spell,
						-- require("none-ls.diagnostics.eslint"), -- requires none-ls-extras.nvim
					},
				})
			end,
		},
		{
			"chrisgrieser/nvim-various-textobjs",
			event = "VeryLazy",
			opts = {
				keymaps = {
					useDefaults = true,
				},
			},
		},
	},

	keys = function()
		vim.keymap.set("n", "<leader>y", "<cmd>YankBank<CR>", { noremap = true })
		vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { silent = true })
		vim.keymap.set("n", "<leader>t", ":ToggleTerm size=50 direction=vertical<cr>", { silent = true })

        vim.keymap.set("n", "P", function()
            require("various-textobjs").lastChange()
            local changeFound = vim.fn.mode():find("v")
            if changeFound then vim.cmd.normal { ">", bang = true } end
        end)

	end,
}
