return {
    { "nvim-lua/plenary.nvim" },
    { "nvim-tree/nvim-web-devicons" },
    {
        "hrsh7th/nvim-cmp",
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "nvim_lua" },
                    { name = "go_pkgs" },
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
                            go_pkgs = "[pkgs]",
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
            { "Snikimonkd/cmp-go-pkgs" },
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
        "Wansmer/treesj",
        config = function()
            require("treesj").setup({
                use_default_keymaps = false,
                max_join_length = 1000,
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
        "mcauley-penney/visual-whitespace.nvim",
        config = true,
        event = "ModeChanged *:[vV\22]",
        opts = {},
    },
    {
        "yamatsum/nvim-cursorline",
        config = function()
            require("nvim-cursorline").setup({
                cursorline = { enable = false },
                cursorword = { enable = true, min_length = 3, hl = { underline = true } },
            })
        end,
    },
    {
        "stevearc/conform.nvim",
        cmd = { "ConformInfo" },
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    css = { "prettier" },
                    go = { "gofmt" },
                    html = { "prettier" },
                    javascript = { "prettier" },
                    javascriptreact = { "prettier" },
                    json = { "prettier" },
                    lua = { "stylua" },
                    python = { "isort", "black" },
                    typescript = { "prettier" },
                    typescriptreact = { "prettier" },
                    vue = { "prettier" },
                    yaml = { "prettier" },
                },
                formatters = {
                    black = {
                        prepend_args = {
                            "--skip-string-normalization",
                            "--skip-magic-trailing-comma",
                        },
                    },
                    gofmt = {
                        prepend_args = { "-s" },
                    },
                    prettier = {
                        prepend_args = {
                            "--tab-width",
                            "2",
                            "--single-quote",
                            "--no-semi",
                            "--trailing-comma",
                            "all",
                        },
                    },
                },
            })
        end,
    },
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
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<CR>",
                        node_incremental = "<CR>",
                        node_decremental = "<S-CR>",
                    },
                },
            })
        end,
    },
    {
        "chrisgrieser/nvim-various-textobjs",
        opts = { keymaps = { useDefaults = true } },
    },
    {
        "folke/noice.nvim",
        opts = {
            top_down = false,
            presets = {
                bottom_search = true,
                command_palette = true,
            },
            lsp = {
                progress = {
                    enabled = false,
                },
            },
        },
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
    { "aaronik/treewalker.nvim" },
    {
        "esmuellert/nvim-eslint",
        config = function()
            require("nvim-eslint").setup({})
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
        "bullets-vim/bullets.vim",
    },
    {
        "arnamak/stay-centered.nvim",
        lazy = false,
        opts = {
        },
    },
    {
        "youyoumu/pretty-ts-errors.nvim",
        opts = {
            executable = "pretty-ts-errors-markdown",
            float_opts = {
                border = "rounded",
                max_width = 80,
                max_height = 20,
                wrap = true,
            },
            auto_open = false,
            lazy_window = false,
        },
    },
    {
        "dmmulroy/ts-error-translator.nvim",
        config = function()
            require("ts-error-translator").setup({
                auto_attach = true,

                servers = {
                    "ts_ls",
                    "typescript-tools",
                    "vtsls",
                },
            })
        end,
    },
    {
        "pmizio/typescript-tools.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "neovim/nvim-lspconfig",
        },
        opts = {},
    },
    {
        "OXY2DEV/markview.nvim",
        lazy = false,
        opts = {
            preview = {
                filetypes = { "markdown", "codecompanion" },
                ignore_buftypes = {},
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
        "folke/twilight.nvim",
        config = function()
            require("twilight").setup({
                dimming = { alpha = 0.20 },
                context = 18,
                expand = {
                    "function",
                    "method",
                    "table",
                    "if_statement",
                },
            })
        end
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
        dependencies = { { "nvim-mini/mini.icons", opts = {} } },
        lazy = false,
    },
}
