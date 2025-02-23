-- Editor settings

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 4
vim.opt.cursorline = true
vim.opt.colorcolumn = "80,100"
vim.opt.scrolloff = 5

vim.opt.wrap = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.foldmethod = "syntax"
vim.opt.foldnestmax = 10
vim.opt.foldlevel = 10

vim.opt.autoread = true
vim.api.nvim_create_autocmd(
  { "BufEnter", "CursorHold", "CursorHoldi", "FocusGained" },
  { command = "if mode() != 'c' | checktime | endif", pattern = { "*" } }
)

vim.api.nvim_create_autocmd({ "TermOpen" }, {
  group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end,
})

-- vgit
vim.o.updatetime = 300
vim.o.incsearch = false
vim.wo.signcolumn = "yes"

-- nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

-- indentLine
vim.g.indentLine_char = "▏"
vim.g.indentLine_setConceal = 0

-- copilot
-- enable copilot for mdx
vim.g.copilog_filetypes = { "mdx" }

vim.g.mapleader = " "

require "plugin_manager"

require "keymaps"
require "auto"
