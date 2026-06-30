return {
  {
    'L3MON4D3/LuaSnip',
    version = '2.*',
    build = (function()
      -- Build Step is needed for regex support in snippets.
      -- This step is not supported in many windows environments.
      -- Remove the below condition to re-enable on windows.
      if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
        return
      end
      return 'make install_jsregexp'
    end)(),
    dependencies = {
      {
        'rafamadriz/friendly-snippets',
        config = function()
          require('luasnip.loaders.from_vscode').lazy_load()
        end,
      },
      {
        'benfowler/telescope-luasnip.nvim',
        config = function()
          require('telescope').load_extension 'luasnip'
        end,
      },
    },
    opts = {},
    config = function()
      local ls = require('luasnip')
      require('luasnip.loaders.from_snipmate').lazy_load { paths = { './snippets' } }
      vim.keymap.set({'n', 'i', 's'}, '<C-e>', function() ls.expand_auto() end, {desc = 'Expand or jump snippet under cursor'})
    end,
  },
}
