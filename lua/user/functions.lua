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

function insert_text(fn)
  local text = nil
  if type(fn) == "function" then
    text = tostring(fn())
  else
    text = tostring(fn)
  end
  vim.api.nvim_paste(text, false, -1)
end

local counters = {}

function contador(key, begin, step)
  key = key or "a"
  begin = begin or 0
  step = step or 1
  if counters[key] == nil then
    counters[key] = { atual = begin, step = step }
  end

  insert_text(counters[key].atual)
  counters[key].atual = counters[key].atual + counters[key].step
end

function definir_contador(key, begin, step)
  key = key or "a"
  begin = begin or 0
  step = step or 1
  counters[key] = { atual = begin, step = step }
end

local function contador_command(opts)
  opts.fargs[2] = opts.fargs[2] and tonumber(opts.fargs[2])
  opts.fargs[3] = opts.fargs[3] and tonumber(opts.fargs[3])

  contador(opts.fargs[1], opts.fargs[2], opts.fargs[3])
end

vim.api.nvim_create_user_command('SortLines', sort_lines, { range = true })
vim.api.nvim_create_user_command('SortUniqueLines', sort_uniq_lines, { range = true })
vim.api.nvim_create_user_command('CloseAllBuffers', '%bd|e#', {})
vim.api.nvim_create_user_command('Contador', contador_command, { nargs='*' })
