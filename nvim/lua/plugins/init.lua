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
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },

  {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup {}
    end,
  },

  -- LuaSnip and cmp_luasnip are configured in completion.lua; avoid duplicate entries here

  {
    "lukas-reineke/indent-blankline.nvim",
    opts = {},
  },


  {
    "ojroques/nvim-osc52",
    config = function()
      require("osc52").setup({ silent = true, tmux_passthrough = true })

      local function has_system_clipboard()
        return vim.fn.executable("xclip") == 1 or vim.fn.executable("xsel") == 1 or vim.fn.executable("wl-copy") == 1
      end

      if not has_system_clipboard() then
        local function copy(lines, _)
          require("osc52").copy(table.concat(lines, "\n"))
        end

        local function paste()
          return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") }
        end

        vim.g.clipboard = {
          name = "osc52",
          copy = { ["+"] = copy, ["*"] = copy },
          paste = { ["+"] = paste, ["*"] = paste },
        }
      end
    end,
  },

  -- replace copilot.vim with a Lua-native client + cmp integration
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({})
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    after = "copilot.lua",
    config = function()
      require("copilot_cmp").setup()
    end,
  },

  "folke/neoconf.nvim",
}
