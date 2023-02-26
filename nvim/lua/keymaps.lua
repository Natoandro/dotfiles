

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.g.mapleader = ' '

map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

map('n', '<leader>r', ':so ~/.config/nvim/init.lua<CR>')
map('n', '<leader>s', ':w<CR>')

-- NvimTree
map('n', '<C-n>', ':NvimTreeToggle<CR>')
-- map('n', '<leader>f', ':NvimTreeRefresh<CR>')
map('n', '<leader>n', ':NvimTreeFindFile<CR>')

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files)
vim.keymap.set('n', '<leader>fg', builtin.live_grep)
vim.keymap.set('n', '<leader>fb', builtin.buffers)
vim.keymap.set('n', '<leader>fh', builtin.help_tags)

-- NvimComment
map('n', '<leader>/', ':CommentToggle<CR>')
map('v', '<leader>/', ':CommentToggle<CR>')

-- Buffers/Lualine
map('n', '<leader>1', ':LualineBuffersJump! 1<CR>')
map('n', '<leader>2', ':LualineBuffersJump! 2<CR>')
map('n', '<leader>3', ':LualineBuffersJump! 3<CR>')
map('n', '<leader>4', ':LualineBuffersJump! 4<CR>')
map('n', '<leader>5', ':LualineBuffersJump! 5<CR>')
map('n', '<leader>6', ':LualineBuffersJump! 6<CR>')
map('n', '<leader>7', ':LualineBuffersJump! 7<CR>')
map('n', '<leader>8', ':LualineBuffersJump! 8<CR>')
map('n', '<leader>9', ':LualineBuffersJump! 9<CR>')

map('n', 'gp', ':bprev<CR>')
map('n', 'gn', ':bnext<CR>')

