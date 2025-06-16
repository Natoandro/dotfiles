return {
  {
    "saecki/crates.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      null_ls = {
        enabled = true,
        name = "crates.nvim",
      },
    },
  },

  { "windwp/nvim-autopairs", event = "InsertEnter", config = true },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },

  {
    "terrortylor/nvim-comment",
    config = function()
      require("nvim_comment").setup {
        comment_empty = true,
      }
    end,
  },

  "tpope/vim-surround",

  "Yggdroot/indentLine",

  "alvan/vim-closetag",

  -- "github/copilot.vim",

  "folke/neoconf.nvim",
}
