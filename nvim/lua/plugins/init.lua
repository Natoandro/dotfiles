vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)
  
  use 'wbthomason/packer.nvim'

  use {
    'tanvirtin/vgit.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    }
  }

  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons',
    },
    tag = 'nightly'
  }

  use {
    'nvim-lualine/lualine.nvim',
  }

  use 'folke/tokyonight.nvim'

  use 'neovim/nvim-lspconfig'

  use 'jiangmiao/auto-pairs'

  use 'terrortylor/nvim-comment'

end)


require('vgit').setup()

require('nvim-tree').setup({
  view = {
    adaptive_size = true,
  }
})

require('lualine').setup({
  tabline = {
    lualine_b = {'buffers'},
    lualine_z = {'tabs'},
  },
})

require('tokyonight').setup({
  style = 'moon',
  transparent = true,
  styles = {
    -- sidebars = 'transparent',
  },
  dim_inactive = true,
})

vim.cmd[[colorscheme tokyonight]]


require('nvim_comment').setup({
  comment_empty = true,
})


require('plugins.lsp')



