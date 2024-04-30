return {
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "moon",
      -- transparent = true,
      styles = {
        -- sidebars = 'transparent',
      },
      dim_inactive = true,
    },
  },

  {
    "navarasu/onedark.nvim",
    opts = {
      -- style = 'darker',
      style = "deep",
      -- transparent = true,
      toggle_style_key = "<leader>ts",
      toggle_style_list = { "dark", "darker", "cool", "deep", "light" },
    },
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      flavour = "frappe",
      -- transparent_background = true,
    },
  },

  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    opts = {
      -- transparent_mode = true,
    },
  },

  {
    "rebelot/kanagawa.nvim",
    opts = {
      dimInactive = true,
    },
  },

  {
    "baliestri/aura-theme",
    lazy = false,
    priority = 1000,
    config = function(plugin)
      vim.opt.rtp:append(plugin.dir .. "/packages/neovim")
      vim.cmd("colorscheme aura-dark")
    end,
  },

  {
    "projekt0n/github-nvim-theme",
    lazy = false,
    priority = 1000,
  },
}
