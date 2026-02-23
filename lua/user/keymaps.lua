-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

--Lazy git
local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

function _lazygit_toggle()
  lazygit:toggle()
end
vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true, desc = 'Open Lazy[G]it' })

local function map(mode, l, r, opts)
  opts = opts or {}
  opts.buffer = bufnr
  vim.keymap.set(mode, l, r, opts)
end

--map('n', '<C-q>', '<cmd>bw<CR>', { desc = 'Buffer delete' }) -- shift+Quit to close current tab
map('n', 'g1', function()
  require('bufferline').go_to_buffer(1, true)
end, { desc = 'Go to Buffer 1' })
map('n', 'g2', function()
  require('bufferline').go_to_buffer(2, true)
end, { desc = 'Go to Buffer 2' })
map('n', 'g3', function()
  require('bufferline').go_to_buffer(3, true)
end, { desc = 'Go to Buffer 3' })
map('n', 'g4', function()
  require('bufferline').go_to_buffer(4, true)
end, { desc = 'Go to Buffer 4' })
map('n', 'g5', function()
  require('bufferline').go_to_buffer(5, true)
end, { desc = 'Go to Buffer 5' })
map('n', 'g6', function()
  require('bufferline').go_to_buffer(6, true)
end, { desc = 'Go to Buffer 6' })
map('n', 'g7', function()
  require('bufferline').go_to_buffer(7, true)
end, { desc = 'Go to Buffer 7' })
map('n', 'g8', function()
  require('bufferline').go_to_buffer(8, true)
end, { desc = 'Go to Buffer 8' })
map('n', 'g9', function()
  require('bufferline').go_to_buffer(9, true)
end, { desc = 'Go to Buffer 9' })
map('n', 'g0', function()
  require('bufferline').go_to_buffer(-1, true)
end, { desc = 'Go to Buffer -1' })
map('n', '<M-j>', '<cmd>BufferLineCyclePrev<CR>', { desc = 'Go to next Buffer' }) -- Alt+j to move to left
map('n', '<M-k>', '<cmd>BufferLineCycleNext<CR>', { desc = 'Go to previous Buffer' }) -- Alt+k to move to right
map('n', '<M-J>', '<cmd>BufferLineMovePrev<CR>', { desc = 'Move buffer prev' }) -- Alt+Shift+j grab to with you to left
map('n', '<M-K>', '<cmd>BufferLineMoveNext<CR>', { desc = 'Move buffer next' })
