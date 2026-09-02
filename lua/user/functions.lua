local function sort_lines()
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local start_line = start_pos[2] - 1
  local end_line = end_pos[2]
  local lines = vim.api.nvim_buf_get_lines(
      0,
      start_line,
      end_line,
      false
  )

  table.sort(lines)

  vim.api.nvim_buf_set_lines(
    0,
    start_line,
    end_line,
    false,
    lines
  )
end

local function sort_uniq_lines()
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local start_line = start_pos[2] - 1
  local end_line = end_pos[2]
  local lines = vim.api.nvim_buf_get_lines(
    0,
    start_line,
    end_line,
    false
  )

  table.sort(lines)

  local uniq_lines = {}
  local last_line = nil
  for _, line in ipairs(lines) do
    if line ~= last_line then
      table.insert(uniq_lines, line)
      last_line = line
    end
  end

  vim.api.nvim_buf_set_lines(
    0,
    start_line,
    end_line,
    false,
    uniq_lines
  )
end

vim.api.nvim_create_user_command('SortLines', sort_lines, { range = true })
vim.api.nvim_create_user_command('SortUniqueLines', sort_uniq_lines, { range = true })
vim.api.nvim_create_user_command('CloseAllBuffers', '%bd|e#', {})
