if vim.g.loaded_ilspy == 1 then
  return
end
vim.g.loaded_ilspy = 1

local ok, ilspy = pcall(require, "user.plugins.ilspy")
if not ok then
  return
end

ilspy.setup()

vim.api.nvim_create_user_command("ILSpyDecompile", function(opts)
  local bufnr = vim.api.nvim_get_current_buf()
  if opts.args ~= "" then
    local path = vim.fn.fnamemodify(opts.args, ":p")
    local temp = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_set_current_buf(temp)
    vim.api.nvim_buf_set_name(temp, path)
    ilspy.decompile_buffer(temp)
    return
  end
  ilspy.decompile_buffer(bufnr)
end, {
  nargs = "?",
  complete = "file",
  desc = "Decompile current buffer or a DLL with ilspycmd",
})
