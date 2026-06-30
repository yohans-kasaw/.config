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
        "mistweaverco/kulala.nvim",
        ft = { "http" },
        opts = {
            global_keymaps = true,
            ui = {
                display_mode = "float",
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
    {
      "pmizio/typescript-tools.nvim",
      dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
      config = function()
          require("typescript-tools").setup {
            settings = {
                jsx_close_tag = {
                    enable = false,
                    filetypes = { "javascriptreact", "typescriptreact" },
                }
            }
          }
      end
    }
}

