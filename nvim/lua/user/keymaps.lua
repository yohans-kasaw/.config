vim.keymap.set("n", "gl", function()
    vim.diagnostic.open_float(nil, {})
end, { noremap = true, silent = true})

vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap)")
vim.keymap.set( "n", "-", require("fzf-lua").files)
vim.keymap.set("n", "<leader><Space>", require("fzf-lua").buffers)
vim.keymap.set("n", "<Tab>", require("fzf-lua").live_grep_native)
vim.keymap.set("n", "<leader>r", require("fzf-lua").resume)
vim.keymap.set("n", "<leader>w", require("fzf-lua").grep_cword)
vim.keymap.set("n", "<leader>j", require("fzf-lua").jumps)
vim.keymap.set("n", "<leader>s", require("fzf-lua").git_status)
vim.keymap.set("n", "<leader>d", require("fzf-lua").lsp_definitions)
vim.keymap.set("n", "<leader>r", require("fzf-lua").lsp_references)
vim.keymap.set("n", "<leader>q", require("fzf-lua").quickfix)

vim.keymap.set("n", "<C-n>", "<Cmd>noh<CR>")
vim.keymap.set("n", "<leader>o", ":w<CR>")
vim.keymap.set("n", "q", ":q!<CR>")

vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<Down>", "<C-f>", { noremap = true, silent = false })
vim.keymap.set({ "n", "v" }, "<Up>", "<C-b>", { noremap = true, silent = false })
vim.keymap.set("n", "<leader>e", require("oil").toggle_float)

vim.keymap.set("n", ";v", "<cmd>DiffviewOpen<cr>")
vim.keymap.set("n", ";d", "<cmd>DiffviewOpen dev<cr>")
vim.keymap.set("n", ";m", "<cmd>DiffviewOpen main<cr>")
vim.keymap.set("n", ";i", require("mini.diff").toggle_overlay)

vim.keymap.set({ "n", "v" }, "<leader>f", vim.lsp.buf.format)

vim.api.nvim_set_keymap('n', '<leader>yp', ':let @+ = expand("%")<CR>', { noremap = true })

