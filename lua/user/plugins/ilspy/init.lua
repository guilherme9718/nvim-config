local M = {}

local defaults = {
  cmd = { "ilspycmd" },
  args = {},
  filetype = "cs",
  autocmd = true,
}

local function is_executable(cmd)
  if not cmd or #cmd == 0 then
    return false
  end
  return vim.fn.executable(cmd[1]) == 1
end

function M._build_cmd(path)
  local cmd = M.opts.cmd
  if type(cmd) == "string" then
    cmd = { cmd }
  end
  local full = vim.list_extend(vim.deepcopy(cmd), M.opts.args or {})
  table.insert(full, path)
  return full
end

local function set_buffer_output(bufnr, lines)
  vim.api.nvim_buf_set_option(bufnr, "modifiable", true)
  vim.api.nvim_buf_set_option(bufnr, "readonly", false)
  vim.api.nvim_buf_set_option(bufnr, "buftype", "nofile")
  vim.api.nvim_buf_set_option(bufnr, "bufhidden", "wipe")
  vim.api.nvim_buf_set_option(bufnr, "swapfile", false)
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
  if M.opts.filetype and M.opts.filetype ~= "" then
    vim.api.nvim_buf_set_option(bufnr, "filetype", M.opts.filetype)
  end
  vim.api.nvim_buf_set_option(bufnr, "modifiable", false)
  vim.api.nvim_buf_set_option(bufnr, "readonly", true)
  vim.api.nvim_buf_set_option(bufnr, "modified", false)
end

local function decompile(bufnr, path)
  local cmd = M._build_cmd(path)
  if not is_executable(cmd) then
    set_buffer_output(bufnr, {
      "ilspycmd not found on PATH.",
      "Install it with: nix shell nixpkgs#ilspycmd",
      "Or set require('ilspy').setup({ cmd = { '/path/to/ilspycmd' } })",
    })
    return
  end

  if vim.system then
    vim.system(cmd, { text = true }, function(res)
      vim.schedule(function()
        if res.code ~= 0 then
          local err = res.stderr
          if not err or err == "" then
            err = "ilspycmd exited with code " .. tostring(res.code)
          end
          set_buffer_output(bufnr, { "ILSpyCmd failed.", err })
          return
        end
        local out = res.stdout or ""
        local lines = vim.split(out, "\n", { plain = true })
        if #lines == 0 or (#lines == 1 and lines[1] == "") then
          lines = { "(no output)" }
        end
        set_buffer_output(bufnr, lines)
      end)
    end)
  else
    local output = vim.fn.systemlist(cmd)
    if vim.v.shell_error ~= 0 then
      local err = table.concat(output, "\n")
      if err == "" then
        err = "ilspycmd exited with code " .. tostring(vim.v.shell_error)
      end
      set_buffer_output(bufnr, { "ILSpyCmd failed.", err })
      return
    end
    if #output == 0 then
      output = { "(no output)" }
    end
    set_buffer_output(bufnr, output)
  end
end

function M.decompile_buffer(bufnr)
  local path = vim.api.nvim_buf_get_name(bufnr)
  if path == "" then
    return
  end
  decompile(bufnr, path)
end

function M._on_buf_read(args)
  M.decompile_buffer(args.buf)
end

function M._setup_autocmd()
  if M._autocmd_set then
    return
  end
  vim.api.nvim_create_autocmd("BufReadCmd", {
    pattern = "*.dll",
    callback = M._on_buf_read,
    desc = "Decompile DLLs with ilspycmd",
  })
  M._autocmd_set = true
end

function M.setup(opts)
  M.opts = vim.tbl_deep_extend("force", {}, defaults, opts or {})
  if M.opts.autocmd then
    M._setup_autocmd()
  end
end

return M
