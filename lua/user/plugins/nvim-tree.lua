return {
  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      is_windows = vim.fn.has 'win32'
      local config = {
        filesystem_watchers = {
          enable = true,
        },
        git = {
          enable = false,
        },
        diagnostics = {
          enable = false,
        }
      }
      if is_windows then
        config.filesystem_watchers.enable = false
      end

      require('nvim-tree').setup(config)
    end,
  },
}
