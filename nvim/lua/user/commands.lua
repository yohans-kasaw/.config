local fzf = require("fzf-lua")

local function create_fzf_cmd(cmd, fzf_func, opts)
    opts = opts or {}
    local desc = opts.desc or ("FzfLua " .. fzf_func)
    vim.api.nvim_create_user_command(cmd, function()
        require("fzf-lua")[fzf_func]()
    end, { desc = desc })
end

create_fzf_cmd("Symbols", "lsp_document_symbols", { desc = "Document Symbols" })
create_fzf_cmd("CodeActions", "lsp_code_actions", { desc = "LSP Code Actions" })
create_fzf_cmd("Blame", "git_bcommits", { desc = "Git Buffer Commits (Blame)" })
create_fzf_cmd("GitStatus", "git_status", { desc = "Git Status" })
create_fzf_cmd("Quickfix", "quickfix", { desc = "Quickfix List" })
create_fzf_cmd("Lines", "lines", { desc = "Search Lines (All Buffers)" })
create_fzf_cmd("Projects", "grep_project", { desc = "Grep Project" })
create_fzf_cmd("Commits", "git_commits", { desc = "Git Commits (Project)" })
create_fzf_cmd("Diagnostics", "diagnostics_document", { desc = "Document Diagnostics" })
create_fzf_cmd("WDiagnostics", "diagnostics_workspace", { desc = "Workspace Diagnostics" })
create_fzf_cmd("Buffers", "buffers", { desc = "Find Buffers" })
create_fzf_cmd("Keymaps", "keymaps", { desc = "Keymaps" })
create_fzf_cmd("Help", "help_tags", { desc = "Help Tags" })
create_fzf_cmd("Man", "man_pages", { desc = "Man Pages" })
create_fzf_cmd("Schemes", "colorschemes", { desc = "Colorschemes" })
create_fzf_cmd("Marks", "marks", { desc = "Marks" })
create_fzf_cmd("Jumps", "jumps", { desc = "Jumps" })
create_fzf_cmd("Spell", "spell_suggest", { desc = "Spelling Suggestions" })
create_fzf_cmd("Commands", "commands", { desc = "Neovim Commands" })

-- tern this to command
-- vim.api.nvim_set_keymap(
--     "n",
--     "<leader>im",
--     [[<cmd>lua require'telescope'.extensions.goimpl.goimpl{}<CR>]],
--     { noremap = true, silent = true }
-- )
--
--
-- vim.keymap.set({ "n", "v" }, "<leader>n", function()
--     local mode = vim.fn.mode()
--     require("focus").toggle_zen({
--         zen = {
--             opts = {},
--         },
--     })
--     if mode == "v" or mode == "V" then
--         local start = vim.fn.line("v")
--         local cursor = vim.fn.line(".")
--
--         require("focus").toggle_narrow({
--             line1 = math.min(start, cursor),
--             line2 = math.max(start, cursor),
--         })
--     else
--         require("focus").toggle({
--             window = {
--                 width = 0.50,
--             },
--         })
--     end
-- end)
