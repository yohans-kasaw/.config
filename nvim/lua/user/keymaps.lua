-- Diagnostics
vim.keymap.set("n", "gl", function()
    vim.diagnostic.open_float(nil, {})
end, { noremap = true, silent = true, desc = "Show Line Diagnostics" })

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
vim.keymap.set("n", "-", require("fzf-lua").files, { desc = "Find Files" })
vim.keymap.set("n", "<Tab>", require("fzf-lua").live_grep_native, { desc = "Grep" })
vim.keymap.set("n", "<leader>r", require("fzf-lua").resume, { desc = "Resume Last Search" })
vim.keymap.set("n", "<leader>g", require("fzf-lua").live_grep_native, { desc = "Grep" })
vim.keymap.set("n", "<leader>w", require("fzf-lua").grep_cword, { desc = "Search Word Under Cursor" })

vim.keymap.set("n", "<leader>ld", require("fzf-lua").lsp_definitions, { silent = true, desc = "Go to Definition" })
vim.keymap.set("n", "<leader>lr", require("fzf-lua").lsp_references, { silent = true, desc = "Find References" })
vim.keymap.set("n", "<leader>lf", require("fzf-lua").lsp_finder, { silent = true, desc = "Find References" })

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


-- trail
vim.keymap.set({ "n", "v" }, "<S-Up>", "<cmd>Treewalker Up<cr>", { silent = true })
vim.keymap.set({ "n", "v" }, "<S-Down>", "<cmd>Treewalker Down<cr>", { silent = true })
vim.keymap.set({ "n", "v" }, "<S-Left>", "<cmd>Treewalker Left<cr>", { silent = true })
vim.keymap.set({ "n", "v" }, "<S-Right>", "<cmd>Treewalker Right<cr>", { silent = true })

-- swapping
vim.keymap.set("n", "<C-S-Up>", "<cmd>Treewalker SwapUp<cr>", { silent = true })
vim.keymap.set("n", "<C-S-Down>", "<cmd>Treewalker SwapDown<cr>", { silent = true })

vim.keymap.set("n", "<leader>e", function()
    require("oil").toggle_float()
end, { desc = "Open parent directory" })

-- snippets
vim.keymap.set("i", "<C-e>", "if err != nil {\n\tfmt.Println(err)\n}<Esc>", { silent = true })
vim.keymap.set("i", "<C-l>", "fmt.Println()<Esc>", { remap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-t>", '<C-R>=strftime("%H:%M")<CR>', { noremap = true })

vim.keymap.set({ "n", "v" }, "<leader>lf", vim.lsp.buf.format, { desc = "Format file" })

vim.keymap.set("n", "<A-d>", vim.diagnostic.setqflist, { desc = "Preview in Quickfix" })
vim.keymap.set("n", "<leader>q", require("fzf-lua").quickfix, { desc = "Grep" })
vim.keymap.set("n", "<A-h>", "<cmd>cnext<cr>", { desc = "Next in Quickfix" })
vim.keymap.set("n", "<A-l>", "<cmd>cprev<cr>", { desc = "Preview in Quickfix" })
vim.keymap.set("n", "<A-o>", "<cmd>copen<cr>", { desc = "Open Quickfix" })
vim.keymap.set("n", ";v", "<cmd>DiffviewOpen<cr>", { desc = "toggle diff view" })
vim.keymap.set("n", ";d", "<cmd>DiffviewOpen dev<cr>", { desc = "toggle diff view" })
vim.keymap.set("n", ";g", "<cmd>Neogit<cr>", { desc = "toggle diff view" })
vim.keymap.set("n", ";c", "<cmd>Assistant<cr>", { desc = "Preview in Quickfix" })

vim.api.nvim_create_autocmd("FileType", {
    pattern = "qf",
    callback = function(args)
        vim.api.nvim_buf_set_keymap(args.buf, "n", "q", "<cmd>cclose<cr>", { noremap = true, silent = true })
    end,
    desc = "Close quickfix window with q",
})

-- Normal and Visual modes
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d')
vim.keymap.set({ "n", "v" }, "<leader>D", '"_D')
vim.keymap.set({ "n", "v" }, "<leader>dd", '"_dd')
vim.keymap.set("n", "gv", "`[v`]", { desc = "Reselect last pasted text" })
vim.api.nvim_set_keymap(
    "n",
    "<leader>im",
    [[<cmd>lua require'telescope'.extensions.goimpl.goimpl{}<CR>]],
    { noremap = true, silent = true }
)

-- add breakpoint using dap
vim.keymap.set("n", "<leader>db", require("dap").toggle_breakpoint, { silent = true })
-- run cursor
vim.keymap.set("n", "<leader>dr", require("dap").run_to_cursor, { silent = true })

-- lets use ctr- the arrow for continue and such
vim.keymap.set("n", "<C-Right>", require("dap").continue)
vim.keymap.set("n", "<C-Down>", require("dap").step_over, { silent = true })
vim.keymap.set("n", "<C-Up>", require("dap").step_out, { silent = true })

-- have storte over as C-c
vim.keymap.set("n", "<leader>m", require("treesj").toggle)
-- For extending default preset with `recursive = true`
vim.keymap.set("n", "<leader>M", function()
    require("treesj").toggle({ split = { recursive = true } })
end)

vim.keymap.set("n", ";i", function()
    require("mini.diff").toggle_overlay(0)
end)

vim.keymap.set({ "n", "v" }, "<leader>n", function()
    local mode = vim.fn.mode()
    require("focus").toggle_zen({
        zen = {
            opts = {},
        },
    })
    if mode == "v" or mode == "V" then
        local start = vim.fn.line("v")
        local cursor = vim.fn.line(".")

        require("focus").toggle_narrow({
            line1 = math.min(start, cursor),
            line2 = math.max(start, cursor),
        })
    else
        require("focus").toggle({
            window = {
                width = 0.50,
            },
        })
    end
end)

vim.keymap.set({ "n" }, ";t", function()
    local time = os.date("### --- %H:%M ---")
    vim.api.nvim_put({ time }, "l", false, true)
end)

vim.keymap.set("n", "<leader>te", function()
    require("pretty-ts-errors").show_formatted_error()
end, { desc = "Show TS error" })
