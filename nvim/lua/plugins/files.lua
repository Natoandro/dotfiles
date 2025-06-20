return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      view = {
        adaptive_size = true,
        number = true,
        relativenumber = true,
        centralize_selection = true,
        width = 40,
      },
      update_focused_file = {
        enable = true,
      },
      renderer = {
        group_empty = true,
      },
    },
  },

  "ThePrimeagen/harpoon",
  -- {
  -- 	"folke/persistence.nvim",
  -- 	event = "BufReadPre",
  -- 	opts = {},
  -- },
  -- {
  --   "rmagatti/auto-session",
  --   opts = {
  --     log_level = "error",
  --     auto_session_enabled = true,
  --   },
  -- },
}
