local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local bufopts = { noremap = true, silent = true }

map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-n>", ":NvimTreeToggle<CR>")

map("n", "<leader>R", ":so ~/.config/nvim/init.lua<CR>")
map("n", "<leader>s", ":w<CR>")

-- Telescope
local builtin = require "telescope.builtin"
vim.keymap.set("n", "<leader>ff", builtin.find_files)
vim.keymap.set("n", "<leader>fg", builtin.live_grep)
vim.keymap.set("n", "<leader>tb", builtin.buffers)
vim.keymap.set("n", "<leader>th", builtin.help_tags)
vim.keymap.set("n", "<leader>tt", builtin.treesitter)
vim.keymap.set("n", "<leader>gc", builtin.git_commits)
vim.keymap.set("n", "<leader>gC", builtin.git_bcommits)
vim.keymap.set("n", "<leader>gb", builtin.git_branches)
vim.keymap.set("n", "<leader>gs", builtin.git_status)
vim.keymap.set("n", "<leader>tc", builtin.colorscheme)
vim.keymap.set("n", "<leader>tq", builtin.quickfix)
vim.keymap.set("n", "<leader>tj", builtin.jumplist)
vim.keymap.set("n", "<leader>fb", ":Telescope file_browser path=%:p:h select_buffer=true hidden=true<CR>")
vim.keymap.set("n", "<leader>is", function()
  builtin.symbols { sources = { "emoji" } }
end)

vim.keymap.set("n", "<leader>F", function()
  vim.lsp.buf.format { async = true }
end, bufopts)

-- NvimComment
map("n", "<leader>/", ":CommentToggle<CR>")
map("v", "<leader>/", ":CommentToggle<CR>")

-- Buffers/Lualine
map("n", "<leader>1", ":LualineBuffersJump! 1<CR>")
map("n", "<leader>2", ":LualineBuffersJump! 2<CR>")
map("n", "<leader>3", ":LualineBuffersJump! 3<CR>")
map("n", "<leader>4", ":LualineBuffersJump! 4<CR>")
map("n", "<leader>5", ":LualineBuffersJump! 5<CR>")
map("n", "<leader>6", ":LualineBuffersJump! 6<CR>")
map("n", "<leader>7", ":LualineBuffersJump! 7<CR>")
map("n", "<leader>8", ":LualineBuffersJump! 8<CR>")
map("n", "<leader>9", ":LualineBuffersJump! 9<CR>")

map("n", "gh", ":bprev<CR>")
map("n", "gl", ":bnext<CR>")

local harpoon_ui = require "harpoon.ui"
local harpoon_mark = require "harpoon.mark"
vim.keymap.set("n", "<leader>hh", harpoon_ui.toggle_quick_menu)
vim.keymap.set("n", "<leader>hm", harpoon_mark.add_file)
-- avoid overriding built-in motions `gp` and `gn`
vim.keymap.set("n", "<leader>hp", harpoon_ui.nav_prev)
vim.keymap.set("n", "<leader>hn", harpoon_ui.nav_next)

vim.keymap.set("i", "<M-.>", "<Plug>(copilot-next)")
vim.keymap.set("i", "<M-,>", "<Plug>(copilot-previous)")

-- NES (next-edit-suggestion) helpers
vim.keymap.set("n", "<leader>p", function()
  local ok, s = pcall(require, "copilot.suggestion")
  if ok and s then
    s.accept_and_goto()
  end
end)

vim.keymap.set("n", "<leader>tT", function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd "L"
end)
