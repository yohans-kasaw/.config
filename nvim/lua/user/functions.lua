function get_grapple_status()
	local current_buf_path = vim.api.nvim_buf_get_name(0)
	local file_path
	if current_buf_path == "" then
		file_path = "[No Name]"
	else
		file_path = vim.fn.pathshorten(vim.fn.fnamemodify(current_buf_path, ":.:r"))
	end

	local right_part = file_path .. "%m%r%w"

	if not pcall(require, "grapple") then
		return right_part
	end

	local grapple = require("grapple")
	local tags = grapple.tags()

	local file_list = {}
	for _, tag in ipairs(tags) do
		local file_name = vim.fn.fnamemodify(tag.path, ":t:r")
		if tag.path == current_buf_path then
			file_name = string.format("[%s]", file_name)
		end
		table.insert(file_list, file_name)
	end

	return table.concat(file_list, " ") .. "%=" .. right_part
end
