return {
    { "nvim-tree/nvim-web-devicons" },
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
            cmp.event:on(
                "confirm_done",
                require("nvim-autopairs.completion.cmp").on_confirm_done()
            )
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
    { "HiPhish/rainbow-delimiters.nvim" },
    {
        "ibhagwan/fzf-lua",
        config = function()
            require("fzf-lua").setup({
                fzf_opts = { ["--layout"] = "default" },
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
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter").setup({
                auto_install = true,
                highlight = { enable = true },
                indent = {
                    enable = true,
                    disable = { "markdown", "typescript", "tsx" },
                },
            })
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
        "mistweaverco/kulala.nvim",
        ft = { "http" },
        opts = {
            global_keymaps = true,
            global_keymaps_prefix = ".",
            ui = {
                display_mode = "float",
            },
        },
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            scope = {
                enabled = false,
            },
            indent = {
                char = "┊",
            },
        },
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
            require("oil").setup({
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
                }
            })
        end,
        lazy = false,
    },
}
