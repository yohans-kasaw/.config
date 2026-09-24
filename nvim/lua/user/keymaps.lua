vim.keymap.set("n", "gl", function()
    vim.diagnostic.open_float(nil, {})
end, { noremap = true, silent = true})

vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap)")
vim.keymap.set( "n","<leader><Space>", require("fzf-lua").files)
vim.keymap.set("n","<Tab>", require("fzf-lua").live_grep_native)

-- fzf
vim.keymap.set("n", "<leader>b", require("fzf-lua").buffers)
vim.keymap.set("n", "<leader>fr", require("fzf-lua").resume)
vim.keymap.set("n", "<leader>w", require("fzf-lua").grep_cword)
vim.keymap.set("n", "<leader>j", require("fzf-lua").jumps)
vim.keymap.set("n", "<leader>d", require("fzf-lua").lsp_definitions)
vim.keymap.set("n", "<leader>r", require("fzf-lua").lsp_references)
vim.keymap.set("n", "<leader>i", require("fzf-lua").lsp_implementations)
vim.keymap.set("n", "<leader>t", require("fzf-lua").lsp_typedefs)
vim.keymap.set("n", "<leader>q", require("fzf-lua").quickfix)
vim.keymap.set("n", "<leader>s", require("fzf-lua").git_status)
vim.keymap.set("n", "<leader>gc", require("fzf-lua").git_commits)
vim.keymap.set("n", "<leader>D", require("fzf-lua").diagnostics_workspace)
vim.keymap.set("n", "<leader>la", require("fzf-lua").lsp_code_actions)

-- lsp
vim.keymap.set('n', '<leader>lr', function() 
    vim.cmd("lsp restart")
    vim.notify("Dude!! I'm restarting the lsp", vim.log.levels.INFO)
end, { desc = 'Restart LSP' })

vim.keymap.set({ "n", "v" }, "<leader>f", vim.lsp.buf.format)
vim.keymap.set("n", "<leader>e", require("oil").toggle_float)
vim.keymap.set("n", "<leader>o", ":w<CR>")

-- ; 
local fzf = require("fzf-lua")
local function open_fzf_with_split(split_cmd)
    fzf.files({
        actions = {
            ["default"] = function(selected)
                if selected and #selected > 0 then
                    local file = fzf.path.entry_to_file(selected[1]).path
                    vim.cmd(split_cmd .. " " .. vim.fn.fnameescape(file))
                end
            end,
        },
    })
end

local function open_vsplit_fzf()
  open_fzf_with_split("rightbelow vsplit")
end

local function open_hsplit_fzf()
  open_fzf_with_split("rightbelow split")
end

vim.api.nvim_set_keymap('n', ';.', ':bd<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', ';C', ':%bd<CR>', { noremap = true })
vim.keymap.set("n", ";<Space>", "<C-w>w", { noremap = true, silent = true, desc = "Cycle next split window" })
vim.keymap.set("n", ";<CR>", open_vsplit_fzf, { noremap = true, silent = true, desc = "Open file in vertical split" })
vim.keymap.set("n", ";h", open_hsplit_fzf, { noremap = true, silent = true, desc = "Open file in horizontal split" })
vim.keymap.set("n", ";v", "<cmd>DiffviewOpen<cr>")
vim.keymap.set("n", ";d", "<cmd>DiffviewOpen dev<cr>")
vim.keymap.set("n", ";m", "<cmd>DiffviewOpen main<cr>")
vim.keymap.set("n", ";i", require("mini.diff").toggle_overlay)
vim.keymap.set("n", ";t", "<cmd>TailwindFoldToggle<cr>")
vim.keymap.set('n', ';y', ':let @+ = expand("%")<CR>', { noremap = true })


-- msc
vim.keymap.set({ "n", "v" }, "<Down>", "<C-f>", { noremap = true, silent = false })
vim.keymap.set({ "n", "v" }, "<Up>", "<C-b>", { noremap = true, silent = false })
vim.keymap.set("n", "<C-n>", "<Cmd>noh<CR>")
vim.keymap.set("n", "q", ":q!<CR>")

vim.keymap.set("n", "j",function() 
    return (vim.v.count == 0 and "gj") or "j"
end,{expr=true})

vim.keymap.set("n", "k",function() 
    return (vim.v.count == 0 and "gk") or "k"
end,{expr=true})
