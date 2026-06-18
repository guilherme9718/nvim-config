return {
  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format()
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      async = true,
      lsp_format = 'fallback',
      formatters_by_ft = {
        lua = { 'stylua' },
        cs = { 'csharpier' },
        json = { 'fixjson' },
      },
    },
  },
}
