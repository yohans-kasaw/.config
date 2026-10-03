local M = {}

function M.file_buffer_count()
  local count = 0

  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[bufnr].buflisted
      and vim.bo[bufnr].buftype == ""
      and vim.api.nvim_buf_get_name(bufnr) ~= "" then
      count = count + 1
    end
  end

  return count
end

function M.tile_command(exclude_current)
    local count = M.file_buffer_count()
    if exclude_current then
        count = math.max(0, count - 1)
    end

    if count == 0 then
        return nil            -- normal open, no split
    elseif count == 1 then
        return "rightbelow vsplit"
    else
        return "rightbelow split"
    end
end

function M.tile_open(path, open_fn, exclude_current)
    local cmd = M.tile_command(exclude_current)

    if cmd and path then
        vim.cmd(cmd .. " " .. vim.fn.fnameescape(path))
        return
    end

    if open_fn then
        return open_fn()
    elseif path then
        vim.cmd("edit " .. vim.fn.fnameescape(path))
    end
end

return M
