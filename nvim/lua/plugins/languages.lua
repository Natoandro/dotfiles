return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("lsp").setup()
    end,
  },

  {
    "simrat39/inlay-hints.nvim",
    config = function()
      require("inlay-hints").setup()
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = { "lua", "rust", "toml", "javascript", "typescript", "tsx", "python", "svelte" },
        auto_install = true,
        sync_install = false,
        highlight = {
          enable = true,
        },
        rainbow = {
          enable = true,
          extended_mod = true,
        },
        modules = {},
        ignore_install = {},
        additional_vim_regex_highlighting = false,
      }
    end,
    -- opts = {},
  },
  "nvim-treesitter/nvim-treesitter-context",

  "maxmellon/vim-jsx-pretty",

  {
    "lukas-reineke/lsp-format.nvim",
    opts = {},
  },

  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local null_ls = require "null-ls"
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

      null_ls.setup {
        sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.diagnostics.eslint,
          null_ls.builtins.completion.spell,
          null_ls.builtins.diagnostics.mypy,
          null_ls.builtins.diagnostics.ruff,
          null_ls.builtins.formatting.black,
        },
        on_attach = function(client, bufnr)
          if client.supports_method "textDocument/formatting" then
            vim.api.nvim_clear_autocmds {
              group = augroup,
              buffer = bufnr,
            }
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format { bufnr = bufnr }
              end,
            })
          end
        end,
        should_attach = function(bufnr)
          return not vim.api.nvim_buf_get_name(bufnr):match "\x2esvelte$"
        end,
      }
    end,
  },

  {
    "simrat39/inlay-hints.nvim",
    config = true,
  },

  "udalov/kotlin-vim",

  -- "lervag/vimtex",
  -- {
  -- 	"lervag/vimtex",
  -- 	lazy = false,
  -- 	init = function()
  -- 		vim.g.vimtex_view_method = "zathura"
  -- 	end,
  -- },
  {
    "f3fora/nvim-texlabconfig",
    config = function()
      require("texlabconfig").setup()
    end,
    ft = { "tex", "bib" },
    build = "go build",
  },

  "jparise/vim-graphql",

  -- "joeveiga/ng.nvim",
  "nvim-treesitter/nvim-treesitter-angular",

	"jghauser/follow-md-links.nvim",

	{
		"ray-x/go.nvim",
		dependencies = { -- optional packages
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("go").setup()
		end,
		event = { "CmdlineEnter" },
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
	},
}
