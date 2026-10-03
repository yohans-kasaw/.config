return {
    {
        "hrsh7th/nvim-cmp",
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "nvim_lua" },
                }, {
                    { name = "treesitter" },
                    { name = "path" },
                    { name = "buffer" },
                }),
                completion = {
                    autocomplete = false,
                },
                formatting = {
                    format = function(entry, vim_item)
                        vim_item.menu = ({
                            nvim_lsp = "[lsp]",
                            nvim_lua = "[lua]",
                            buffer = "[buf]",
                            path = "[path]",
                            treesitter = "[tree]",
                        })[entry.source.name] or ''
                        return vim_item
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<Tab>"] = cmp.mapping.select_next_item(),
                    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                    ["<CR>"] = cmp.mapping.confirm(),
                }),
                matching = { disallow_symbol_nonprefix_matching = false },
            })
        end,
        dependencies = {
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "ray-x/cmp-treesitter" },
            { "hrsh7th/cmp-nvim-lua" },
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
        "ibhagwan/fzf-lua",
        config = function()
            local fzf = require("fzf-lua")
            local funcs = require("user.funcs")

            fzf.setup({
                fzf_opts = { ["--layout"] = "default" },
                keymap = { fzf = { ["ctrl-q"] = "select-all+accept" } },
            })

            local pickers = {
                "files", "buffers", "git_status", "git_commits", "grep",
                "grep_last", "lgrep", "lgrep_last", "live_grep",
                "oldfiles", "quickfix", "lsp_references", "lsp_definitions",
                "lsp_implementations", "lsp_type_definitions", "lsp_document_symbols",
                "lsp_workspace_symbols", "lsp_live_workspace_symbols",
                "diagnostics_document", "diagnostics_workspace",
                "marks",
            }

            -- Build the wrapped "open" action once, reuse for every picker + key.
            local function make_tile_action(base_action)
                return function(selected, o)
                    local cmd = funcs.tile_command(false)
                    if cmd then
                        vim.cmd(cmd)
                    end

                    if base_action then
                        return base_action(selected, o)
                    end
                    -- fall back to fzf-lua's built-in default behavior
                    return require("fzf-lua.actions").file_edit(selected, o)
                end
            end

            for _, picker in ipairs(pickers) do
                local original = fzf[picker]
                if type(original) == "function" then
                    fzf[picker] = function(opts, ...)
                        opts = opts or {}
                        local user_actions = opts.actions or {}

                        user_actions["default"] = make_tile_action(user_actions["default"])
                        user_actions["enter"]   = make_tile_action(user_actions["enter"])

                        opts.actions = user_actions
                        return original(opts, ...)
                    end
                end
            end
        end,
    },
    {
        url = "https://codeberg.org/andyg/leap.nvim",
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
        "nvim-mini/mini.diff",
        version = false,
        config = function()
            require("mini.diff").setup({
                view = {
                    style = "sign",
                },
                mappings = {
                    reset = "<leader>hr",
                    goto_prev = "<C-Up>",
                    goto_next = "<C-Down>",
                },
            })
        end,
    },
    {
      'nvim-mini/mini.pairs',
      config = function()
        require('mini.pairs').setup({})
      end
    },
    {
      'echasnovski/mini.surround',
      version = false,
      config = function()
        require('mini.surround').setup({})
      end
    },
    { 
        'wellle/targets.vim', 
        version = false 
    },
    {
        "thesimonho/kanagawa-paper.nvim",
        lazy = false,
        priority = 1000,
        init = function()
            require("kanagawa-paper").setup({
                transparent = true,
                diag_background = false,
            })

            vim.cmd.colorscheme("kanagawa-paper-ink")
        end,
        opts = { ... },
    },
    {
        'stevearc/oil.nvim',
        ---@module 'oil'
        ---@type table
        opts = {},
        config = function()
            local oil = require("oil")
            local funcs = require("user.funcs")
            oil.setup({
                default_file_explorer = true,
                delete_to_trash = true,
                view_options = {
                    show_hidden = true,
                },
                float = {
                    max_width = 0.85,
                    max_height = 0.85,
                    min_width = 0.85,
                    min_height = 0.85,
                    border = "rounded",
                },
                keymaps = {
                    ["q"] = { "actions.close", mode = "n" },
                    ["<CR>"] = {
                        callback = function()
                            local entry = oil.get_cursor_entry()
                            local dir = oil.get_current_dir()
                            if not entry or not dir then return end

                            local full_path = dir .. entry.name

                            if entry.type == "directory" then
                                oil.open(full_path)
                                return
                            end

                            oil.close()

                            local cmd = funcs.tile_command(false)

                            if cmd then
                                vim.cmd(cmd .. " " .. vim.fn.fnameescape(full_path))
                            else
                                vim.cmd("edit " .. vim.fn.fnameescape(full_path))
                            end
                        end,
                    },
                }
            })
        end,
        lazy = false,
    },
    {
      'razak17/tailwind-fold.nvim',
      opts= {},
      dependencies = { 'nvim-treesitter/nvim-treesitter' },
      ft = { 'html', 'svelte', 'typescriptreact'},
    }
}

