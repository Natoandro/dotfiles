vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)
  -- Plugin manager
  use 'wbthomason/packer.nvim'

  -- VCS
  use {
    'tanvirtin/vgit.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    }
  }

  -- Explorer
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons',
    },
    tag = 'nightly'
  }

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
    requires = {
      'nvim-lua/plenary.nvim'
    },
  }

  -- View
  use {
    'nvim-lualine/lualine.nvim',
  }


  -- Themes
  use 'folke/tokyonight.nvim'
  use 'navarasu/onedark.nvim'

  -- LSPs
  use 'neovim/nvim-lspconfig'

  -- Editor
  use 'jiangmiao/auto-pairs'
  use 'terrortylor/nvim-comment'
  use 'tpope/tvim-surround'
  use 'Yggdroot/indentLine'

end)

require('plugins.vcs')
require('plugins.view')
require('plugins.files')
require('plugins.themes')
require('plugins.editor')
require('plugins.lsp')


