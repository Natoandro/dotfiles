
require('tokyonight').setup({
  style = 'moon',
  transparent = true,
  styles = {
    -- sidebars = 'transparent',
  },
  dim_inactive = true,
})

require('onedark').setup({
  style = 'darker',
  toggle_style_key = '<leader>ts',
  toggle_style_list = {'dark', 'darker', 'cool', 'deep', 'light'},
})
require('onedark').load()

-- vim.cmd[[colorscheme tokyonight]]

