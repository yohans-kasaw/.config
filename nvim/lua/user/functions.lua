function get_grapple_status()
	local current_buf_path = vim.api.nvim_buf_get_name(0)
	local grapple = require("grapple")
	local tags = grapple.tags()

	if tags == nil then
	    return
	end

	local file_list = {}
	for _, tag in ipairs(tags) do
		local file_name = vim.fn.fnamemodify(tag.path, ":t:r")
		if tag.path == current_buf_path then
			file_name = string.format("[%s]", file_name)
		end
		table.insert(file_list, file_name)
	end

	return table.concat(file_list, " ") .. "%="
end
