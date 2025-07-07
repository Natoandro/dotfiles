return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = true,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "pyright",
        "texlab",
        "ts_ls",
        "vue_ls",
        "biome",
      },
    },
  },

  {
    "zeioth/none-ls-autoload.nvim",
    event = { "BufEnter", "BufNewFile" },
    dependencies = { "williamboman/mason.nvim", "nvimtools/none-ls.nvim" },
    opts = {
      ensure_installed = { "mypy", "black", "stylua", "jq", "codelldb" },
      automatic_setup = true,
    },
  },
}
