-- Diagnostics
vim.keymap.set("n", "gl", function()
    vim.diagnostic.open_float(nil, {})
end, { noremap = true, silent = true, desc = "Show Line Diagnostics" })

-- window
vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })

-- leap
vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap)")

-- fzf
vim.keymap.set(
    "n",
    "-",
    function()
        require("fzf-lua").files()
    end,
    { desc = "Find Files" }
)
vim.keymap.set(
    "n",
    "<leader><Space>",
    function()
        require("fzf-lua").buffers()
    end,

    { desc = "Search Word Under Cursor" }
)
vim.keymap.set("n", "<Tab>", require("fzf-lua").live_grep_native, { desc = "Grep" })
vim.keymap.set("n", "<leader>r", require("fzf-lua").resume, { desc = "Resume Last Search" })
vim.keymap.set("n", "<leader>w", require("fzf-lua").grep_cword, { desc = "Search Word Under Cursor" })
vim.keymap.set("n", "<leader>j", require("fzf-lua").jumps, { desc = "Search Word Under Cursor" })

vim.keymap.set("n", "<leader>ld", require("fzf-lua").lsp_definitions, { silent = true, desc = "Go to Definition" })
vim.keymap.set("n", "<leader>lr", require("fzf-lua").lsp_references, { silent = true, desc = "Find References" })
vim.keymap.set("n", "<leader>lf", require("fzf-lua").lsp_finder, { silent = true, desc = "Find References" })

-- Msc
vim.keymap.set("n", "<C-n>", "<Cmd>noh<CR>", { noremap = true })
vim.keymap.set("n", "<leader>o", ":w<CR>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<Down>", "<C-f>", { noremap = true, silent = false })
vim.keymap.set({ "n", "v" }, "<Up>", "<C-b>", { noremap = true, silent = false })

vim.keymap.set({ "n", "v" }, "<S-Up>", "<cmd>Treewalker Up<cr>", { silent = true })
vim.keymap.set({ "n", "v" }, "<S-Down>", "<cmd>Treewalker Down<cr>", { silent = true })
vim.keymap.set({ "n", "v" }, "<S-Left>", "<cmd>Treewalker Left<cr>", { silent = true })
vim.keymap.set({ "n", "v" }, "<S-Right>", "<cmd>Treewalker Right<cr>", { silent = true })

vim.keymap.set("n", "<leader>e", function()
    require("oil").toggle_float()
end, { desc = "Open parent directory" })

-- snippets
vim.keymap.set({ "n", "v" }, "<leader>lf", vim.lsp.buf.format, { desc = "Format file" })

vim.keymap.set("n", ";v", "<cmd>DiffviewOpen<cr>", { desc = "toggle diff view" })
vim.keymap.set("n", ";d", "<cmd>DiffviewOpen dev<cr>", { desc = "toggle diff view" })
vim.keymap.set("n", ";m", "<cmd>DiffviewOpen main<cr>", { desc = "toggle diff view" })

vim.keymap.set("n", "<leader>m", require("treesj").toggle)
vim.keymap.set("n", ";i", function()
    require("mini.diff").toggle_overlay()
end, { desc = "inline diff" })

vim.keymap.set("n", "<leader>;", "<Plug>(WayfinderOpen)", { desc = "Wayfinder" })
vim.keymap.set("n", ";;", ":Twilight<CR>", { desc = "twilight" })
vim.keymap.set("n", ";p", ":Markview<CR>", { desc = "twilight" })

vim.keymap.set("n", "<CR>", require("incselect").init)
vim.keymap.set("x", "<CR>", require("incselect").parent)
vim.keymap.set({'n', 'v'}, 'x', '"_d')
