vim.o.smoothscroll = true

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

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.copyindent = true
vim.opt.linebreak = true
vim.opt.breakindent = true

vim.o.undofile = true
vim.opt.swapfile = false
vim.o.hidden = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.jumpoptions = "stack"

vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = ""
vim.opt.foldlevelstart = 99
vim.opt.foldlevel = 99
vim.opt.foldnestmax = 2

vim.opt.clipboard = "unnamedplus"


vim.opt.completeopt = { "menu", "menuone", "noselect", "noinsert" }

vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

vim.opt.spellcapcheck = ""

vim.o.guifont = "Monaspace Neon Frozen:h26"

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

vim.opt.list = true
local guide_char = "┊ "
vim.opt.listchars = {
  tab = guide_char,
  multispace = guide_char,
  leadmultispace = guide_char,
}
vim.api.nvim_set_hl(0, "Whitespace", { fg = "#3c3836" })
