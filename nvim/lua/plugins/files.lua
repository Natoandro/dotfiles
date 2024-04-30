return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    tag = "nightly",
    opts = {
      view = {
        adaptive_size = true,
        number = true,
        relativenumber = true,
        centralize_selection = true,
        width = 40,
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
