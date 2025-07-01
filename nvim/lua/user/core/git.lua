return {
	plugins = {
		{
			"lewis6991/gitsigns.nvim",
			config = function()
				require("gitsigns").setup()
			end,
		},
	},
	keys = function()
		local gitsigns = require("gitsigns")

		vim.keymap.set({ "n", "x" }, "<A-Down>", function()
			gitsigns.nav_hunk("next")
		end, { desc = "Next Hunk" })

		vim.keymap.set({ "n", "x" }, "<A-Up>", function()
			gitsigns.nav_hunk("prev")
		end, { desc = "Next Hunk" })

		vim.keymap.set({ "n", "x" }, "<leader>hr", gitsigns.reset_hunk, { desc = "Reset Hunk" })
		vim.keymap.set({ "n", "x" }, "<leader>hp", gitsigns.preview_hunk_inline, { desc = "Preview Hunk Inline" })

		vim.keymap.set({ "n", "x" }, "<leader>hb", function()
			gitsigns.blame_line({ full = true })
		end, { desc = "Blame Line" })
	end,
}
