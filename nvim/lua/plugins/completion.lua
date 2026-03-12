return {
  "hrsh7th/cmp-nvim-lsp",

  "hrsh7th/cmp-buffer",

  "hrsh7th/cmp-path",

  "hrsh7th/cmp-cmdline",

  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        window = {},
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "crates" },
        }, {
          { name = "buffer" },
        }),
      })
    end,
  },

  "saadparwaiz1/cmp_luasnip",
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
  },
}
