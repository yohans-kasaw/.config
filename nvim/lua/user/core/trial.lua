return {
	plugins = {
		{
			"ptdewey/yankbank-nvim",
			dependencies = "kkharji/sqlite.lua",
			config = function()
				require("yankbank").setup({
					persist_type = "sqlite",
				})
			end,
		},
		{
			"akinsho/toggleterm.nvim",
			version = "*",

			config = function()
				require("toggleterm").setup({
					insert_mappings = true,
					-- autochdir = true,
				})
			end,
		},
		{
			"jiaoshijie/undotree",
			dependencies = "nvim-lua/plenary.nvim",
			config = function()
				require("undotree").setup({
					float_diff = false,
					position = "right",
				})
			end,
		},
		{
			"nvimtools/none-ls.nvim",
			config = function()
				local null_ls = require("null-ls")

				null_ls.setup({
					sources = {
						null_ls.builtins.formatting.stylua,
						null_ls.builtins.completion.spell,
						-- require("none-ls.diagnostics.eslint"), -- requires none-ls-extras.nvim
					},
				})
			end,
		},
        {
          'b0o/incline.nvim',
            config = function ()
require('incline').setup({
  render = function(props)
    local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
    local modified = vim.bo[props.buf].modified

    local function get_git_diff()
      local icons = { removed = '', changed = '', added = '' }
      local signs = vim.b[props.buf].gitsigns_status_dict
      local labels = {}
      if signs == nil then
        return labels
      end
      for name, icon in pairs(icons) do
        if tonumber(signs[name]) and signs[name] > 0 then
          table.insert(labels, { icon .. signs[name] .. ' ', group = 'Diff' .. name })
        end
      end
      if #labels > 0 then
        table.insert(labels, { '┊ ' })
      end
      return labels
    end
    local function get_diagnostic_label()
      local icons = {
        error = '',
        warn = '',
        info = '',
        hint = ''
      }
      local label = {}

      local severities = {
        vim.diagnostic.severity.ERROR,
        vim.diagnostic.severity.WARN,
        vim.diagnostic.severity.INFO,
        vim.diagnostic.severity.HINT
      }

      local names = {
        [vim.diagnostic.severity.ERROR] = 'error',
        [vim.diagnostic.severity.WARN] = 'warn',
        [vim.diagnostic.severity.INFO] = 'info',
        [vim.diagnostic.severity.HINT] = 'hint'
      }

      for _, severity in ipairs(severities) do
        local n = #vim.diagnostic.get(props.buf, { severity = severity })
        if n > 0 then
          local name = names[severity]
          table.insert(label, { icons[name] .. n .. ' ', group = 'DiagnosticSign' .. name })
        end
      end
      if #label > 0 then
        table.insert(label, { '┊ ' })
      end
      return label
    end

    return {
      ' ',
      {  get_git_diff() },
      { get_diagnostic_label() },
      modified and { ' *', guifg = '#888888', gui = 'bold' } or '',
      filename,
      ' ',
    }
  end
})
            end,
          event = 'VimEnter',
        },
	},
	keys = function()
		vim.keymap.set("n", "<leader>u", "<cmd>lua require('undotree').toggle()<cr>", { desc = "undo tree" })
		vim.keymap.set("n", "<leader>y", "<cmd>YankBank<CR>", { noremap = true })
		vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { silent = true })
		vim.keymap.set("n", "<leader>t", ":ToggleTerm size=50 direction=vertical<cr>", { silent = true })
	end,
}
