local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


require('lazy').setup({
  {
    'williamboman/mason.nvim',
    build = ":MasonUpdate",
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
      'williamboman/mason.nvim',
      'neovim/nvim-lspconfig',
    },
  },
  {
    'jay-babu/mason-null-ls.nvim',
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "jose-elias-alvarez/null-ls.nvim",
    }
  },

  -- VCS
  {
    'tanvirtin/vgit.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim'
    }
  },

  -- Explorer
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    tag = 'nightly'
  },

  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.1',
    dependencies = {
      'nvim-lua/plenary.nvim'
    },
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make'
  },

  {
    'folke/trouble.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    }
  },

  'ThePrimeagen/harpoon',

  -- View
  {
    'nvim-lualine/lualine.nvim',
  },


  -- Themes
  'folke/tokyonight.nvim',
  'navarasu/onedark.nvim',
  { 'catppuccin/nvim',          name = "catppuccin" },
  { 'ellisonleao/gruvbox.nvim', priority = 1000 },
  'rebelot/kanagawa.nvim',

  -- Languages
  'neovim/nvim-lspconfig',
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
  },
  'lukas-reineke/lsp-format.nvim',
  'nvim-treesitter/nvim-treesitter',
  'nvim-treesitter/nvim-treesitter-context',

  {
    'jose-elias-alvarez/null-ls.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    }
  },

  'udalov/kotlin-vim',

  -- Completion
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-vsnip',
  'hrsh7th/vim-vsnip',

  {
    'saecki/crates.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },

  -- Editor
  'jiangmiao/auto-pairs',
  'terrortylor/nvim-comment',
  'tpope/vim-surround',
  'Yggdroot/indentLine',
  'alvan/vim-closetag',

})

require('mason').setup()

require('plugins.vcs')
require('plugins.view')
require('plugins.files')
require('plugins.themes')
require('plugins.editor')
require('plugins.lsp')
require('plugins.completion')
