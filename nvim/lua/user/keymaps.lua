-- Diagnostics
vim.keymap.set("n", "gl", function()
	vim.diagnostic.open_float(nil, {})
end, { noremap = true, silent = true, desc = "Show Line Diagnostics" })

-- Formatting
vim.keymap.set({ "n", "v" }, "<leader>ff", function()
	require("conform").format({
		lsp_fallback = false,
		async = false,
		timeout_ms = 500,
	})
end, { desc = "Format" })

-- Git integration (gitsigns)
vim.keymap.set({ "n", "x" }, "<A-Down>", function()
	require("gitsigns").nav_hunk("next")
end, { desc = "Next Hunk" })
vim.keymap.set({ "n", "x" }, "<A-Up>", function()
	require("gitsigns").nav_hunk("prev")
end, { desc = "Previous Hunk" })
vim.keymap.set({ "n", "x" }, "<leader>hr", require("gitsigns").reset_hunk, { desc = "Reset Hunk" })
vim.keymap.set({ "n", "x" }, "<leader>hp", require("gitsigns").preview_hunk_inline, { desc = "Preview Hunk Inline" })

-- window
vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })

-- leap
vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap)")

-- fzf
vim.keymap.set("n", "<leader>r", require("fzf-lua").resume, { desc = "Resume Last Search" })
vim.keymap.set("n", "<leader>g", require("fzf-lua").live_grep_native, { desc = "Grep" })
vim.keymap.set({ "n", "x" }, "<leader>w", require("fzf-lua").grep_cword, { desc = "Search Word Under Cursor" })
vim.keymap.set("n", "<leader><space>", require("fzf-lua").files, { desc = "Find Files" })
vim.keymap.set("n", "<leader>b", require("fzf-lua").buffers, { desc = "List Buffers" })

-- Msc
vim.keymap.set("n", "<C-n>", "<Cmd>noh<CR>", { noremap = true })
vim.keymap.set("n", "<leader>o", ":w<CR>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v", "o" }, "H", "0", { noremap = true })
vim.keymap.set({ "n", "v", "o" }, "L", "$", { noremap = true })
vim.keymap.set({ "n", "v" }, "<Down>", "<C-f>", { noremap = true, silent = false })
vim.keymap.set({ "n", "v" }, "<Up>", "<C-b>", { noremap = true, silent = false })
vim.keymap.set("n", "'", "`", { noremap = true })

-- terminal
vim.keymap.set("n", "<leader>t", ":ToggleTerm size=50 direction=vertical<cr>", { silent = true })
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { silent = true })

-- lsp
vim.keymap.set("n", "<C-k>", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
vim.keymap.set("n", "<C-i>", "<cmd>Lspsaga incoming_calls<CR>", { silent = true })
vim.keymap.set("n", "<C-o>", "<cmd>Lspsaga outgoing_calls<CR>", { silent = true })
vim.keymap.set("n", "<C-d>", "<cmd>Lspsaga peek_definition<CR>", { silent = true })
vim.keymap.set("n", "<C-t>", "<cmd>Lspsaga peek_type_definition<CR>", { silent = true })
vim.keymap.set("n", "<C-u>", "<cmd>Lspsaga outline<CR>", { silent = true })
vim.keymap.set("n", "<C-f>", "<cmd>Lspsaga finder<CR>", { silent = true })

-- file navigation

vim.keymap.set("n", "<leader>h", "<cmd>Grapple toggle<cr><cmd>redrawstatus<cr>", { desc = "Tag a file" })
vim.keymap.set("n", "<leader>l", "<cmd>Grapple toggle_tags<cr>", { desc = "Toggle tags menu" })
vim.keymap.set("n", "<D-'>", "<cmd>Grapple select index=1<cr>", { desc = "Select 1 tag" })
vim.keymap.set("n", "<D-,>", "<cmd>Grapple select index=2<cr>", { desc = "Select 2 tag" })
vim.keymap.set("n", "<D-.>", "<cmd>Grapple select index=3<cr>", { desc = "Select 3 tag" })
vim.keymap.set("n", "<D-p>", "<cmd>Grapple select index=4<cr>", { desc = "Select 4 tag" })
vim.keymap.set("n", "<D-y>", "<cmd>Grapple select index=5<cr>", { desc = "Select 5 tag" })
vim.keymap.set("n", "<D-;>", "<cmd>Grapple select index=6<cr>", { desc = "Select 6 tag" })

-- trail
vim.keymap.set({ "n", "v" }, "<S-Up>", "<cmd>Treewalker Up<cr>", { silent = true })
vim.keymap.set({ "n", "v" }, "<S-Down>", "<cmd>Treewalker Down<cr>", { silent = true })
vim.keymap.set({ "n", "v" }, "<S-Left>", "<cmd>Treewalker Left<cr>", { silent = true })
vim.keymap.set({ "n", "v" }, "<S-Right>", "<cmd>Treewalker Right<cr>", { silent = true })

-- swapping
vim.keymap.set("n", "<C-S-Up>", "<cmd>Treewalker SwapUp<cr>", { silent = true })
vim.keymap.set("n", "<C-S-Down>", "<cmd>Treewalker SwapDown<cr>", { silent = true })

vim.keymap.set("n", "<leader>e", "<CMD>Oil --float --preview<CR>", { desc = "Open parent directory" })

-- snippets
vim.keymap.set("i", "<C-e>", "if err != nil {\n\tfmt.Println(err)\n}<Esc>", { silent = true })
vim.keymap.set("i", "<C-l>", "fmt.Println()<Esc>", { remap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-t>", '<C-R>=strftime("%H:%M")<CR>', { noremap = true })

-- trial
vim.keymap.set({ "n", "v" }, "<leader>lf", vim.lsp.buf.format, { desc = "Format file" })
vim.keymap.set({ "n", "v", "o" }, "M", "%")

vim.keymap.set("n", "<A-d>", vim.diagnostic.setqflist, { desc = "Preview in Quickfix" })
vim.keymap.set("n", "<leader>q", require("fzf-lua").quickfix, { desc = "Grep" })
vim.keymap.set("n", "<A-h>", "<cmd>cnext<cr>", { desc = "Next in Quickfix" })
vim.keymap.set("n", "<A-l>", "<cmd>cprev<cr>", { desc = "Preview in Quickfix" })
vim.keymap.set("n", "<A-o>", function()
	if vim.fn.getqflist({ winid = 0 }).winid ~= 0 then
		vim.cmd("cclose")
	else
		vim.cmd("copen")
	end
end, { desc = "Open Quickfix" })

vim.keymap.set("n", "<leader>v", function()
	if next(require("diffview.lib").views) == nil then
		vim.cmd("DiffviewOpen")
	else
		vim.cmd("DiffviewClose")
	end
end, { desc = "toggle diff view" })

vim.keymap.set("n", "<leader>d", function()
	if next(require("diffview.lib").views) == nil then
		vim.cmd("DiffviewOpen dev")
	else
		vim.cmd("DiffviewClose")
	end
end, { desc = "toggle diff view" })

vim.keymap.set("n", "<leader>G", function()
	vim.cmd("Neogit")
end, { desc = "toggle diff view" })
vim.keymap.set("n", "<leader>c", "<cmd>Assistant<cr>", { desc = "Preview in Quickfix" })
