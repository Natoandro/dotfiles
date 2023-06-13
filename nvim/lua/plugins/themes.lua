
require('tokyonight').setup({
  style = 'moon',
  -- transparent = true,
  styles = {
    -- sidebars = 'transparent',
  },
  dim_inactive = true,
})

require('onedark').setup({
  -- style = 'darker',
  style = 'deep',
  -- transparent = true,
  toggle_style_key = '<leader>ts',
  toggle_style_list = {'dark', 'darker', 'cool', 'deep', 'light'},
})
-- require('onedark').load()

-- vim.cmd[[colorscheme tokyonight]]

require('catppuccin').setup({
  flavour = "frappe",
  -- transparent_background = true,
})

require('gruvbox').setup({
  -- transparent_mode = true
})

require('kanagawa').setup({
  dimInactive = true,
})

-- vim.cmd.colorscheme "catppuccin"
vim.cmd.colorscheme "gruvbox"

