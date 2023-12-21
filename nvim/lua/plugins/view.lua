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

  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_c = {
          {
            "filename",
            path = 1,
          },
        },
      },
      inactive_sections = {
        lualine_c = {
          {
            "filename",
            path = 1,
          },
        },
      },
      tabline = {
        -- lualine_a = {
        -- 	{
        -- 		"buffers",
        -- 		mode = 2,
        -- 	},
        -- },
        -- lualine_c = { "%=" },
        -- lualine_y = {
        -- 	{
        -- 		"filename",
        -- 		path = 1,
        -- 	},
        -- },
        lualine_b = {
          {
            "filename",
            path = 1,
          },
        },
        lualine_z = { "tabs" },
      },
    },
  },
}
