vim.g.mapleader = " "
vim.o.smoothscroll = true

-- Looks
vim.opt.termguicolors = true
vim.opt.showtabline = 0
vim.opt.signcolumn = "yes"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.fillchars = { eob = " " }
vim.opt.cursorcolumn = true
vim.opt.cursorline = true
vim.opt.conceallevel = 2
vim.o.showbreak = "↳⋅"

-- Indentation and Formatting
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.copyindent = true
vim.opt.linebreak = true
vim.opt.breakindent = true

-- Core Editor Behavior
vim.o.undofile = true
vim.opt.swapfile = false
vim.o.hidden = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.jumpoptions = "stack"

-- Folding
-- vim.opt.foldmethod = "indent"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = ""
vim.opt.foldlevelstart = 99
vim.opt.foldlevel = 99
vim.opt.foldnestmax = 2

-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- Completion
vim.opt.completeopt = { "menu", "menuone", "noselect", "noinsert" }

-- Plugins and Providers
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- spell
vim.opt.spellcapcheck = ""

-- Neovide
vim.o.guifont = "Monaspace Neon Frozen:h26"

-- git diff
vim.opt.diffopt = {
    "internal",
    "filler",
    "closeoff",
    "context:12",
    "algorithm:histogram",
    "linematch:200",
    "indent-heuristic",
}

vim.opt.fillchars:append { diff = "╱" }

vim.o.autoread = true
vim.o.laststatus = 0
vim.o.winborder = 'rounded'
vim.opt.cmdheight = 0
