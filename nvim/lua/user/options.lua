vim.g.mapleader = " "
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
vim.opt.smartindent = false
vim.opt.autoindent = true
vim.opt.copyindent = true
vim.opt.linebreak = true
vim.opt.breakindent = true

-- Core Editor Behavior
vim.opt.scrolloff = 99999
vim.o.undofile = true
vim.opt.swapfile = false
vim.o.hidden = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.jumpoptions = "stack"

-- Folding
vim.opt.foldmethod = "indent"
-- vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
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
local function enable_spell()
	vim.opt_local.spell = true
	vim.opt_local.spelllang = { "en_us" }
end
vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, {
	desc = "Conditional spell checking activation",
	callback = function(args)
		local ft = vim.bo[args.buf].filetype
		if vim.tbl_contains({ "markdown", "text" }, ft) then
			enable_spell()
		end
	end,
})

-- Neovide
vim.o.guifont = "Monaspace Neon Frozen:h27"
vim.g.neovide_scroll_animation_length = 0
vim.g.neovide_cursor_animation_length = 0
vim.g.neovide_cursor_vfx_mode = ""
vim.g.neovide_cursor_trail_size = 0
vim.g.neovide_confirm_quit = true
