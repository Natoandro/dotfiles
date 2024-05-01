local M = {}

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- vim.api.nvim_create_autocmd("LspAttach", {
-- 	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
-- 	callback = function(args)
-- 		local client = vim.lsp.get_client_by_id(args.data.client_id)
-- 		if client.server_capabilities.inlayHintProvider then
-- 			vim.lsp.inlay_hint.enable(args.buf, true)
-- 		end
-- 	end,
-- })

local on_attach = function(client, bufnr)
  require("lsp-format").on_attach(client)
  -- require("lsp-inlayhints").on_attach(client, bufnr)

  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, bufopts)
  vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, bufopts)
  -- vim.keymap.set("n", "<leader>FF", function()
  -- 	-- vim.lsp.buf.format({ async = true })
  -- 	vim.lsp.buf.format()
  -- end, bufopts)

  local builtin = require "telescope.builtin"
  vim.keymap.set("n", "<leader>fr", builtin.lsp_references, bufopts)
  vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, bufopts)
  vim.keymap.set("n", "<leader>fS", builtin.lsp_workspace_symbols, bufopts)
  vim.keymap.set("n", "<leader>fd", builtin.diagnostics)

  -- if client.server_capabilities.inlayHintProvider then
  vim.lsp.inlay_hint.enable(bufnr, true)
  -- end
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

local lspconfig = require "lspconfig"
local util = lspconfig.util

M.setup = function()
  require("neoconf").setup {}

  lspconfig.pyright.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
    filetypes = { "python" },
    -- root_dir = util.root_pattern("pyproject.toml"),
    root_dir = util.root_pattern "poetry.lock",
  }

  -- require("lspconfig").pylsp.setup({
  --   on_attach = on_attach,
  --   capabilities = capabilities,
  --   flags = lsp_flags,
  --   root_dir = util.root_pattern("pyproject.toml"),
  --   settings = {
  --     pylsp = {
  --       plugins = {
  --         pycodestyle = {
  --           ignore = { "W391" },
  --           maxLineLength = 100,
  --         },
  --       },
  --     },
  --   },
  -- })

  -- require('lspconfig')['tsserver'].setup{
  --     on_attach = on_attach,
  --     flags = lsp_flags,
  -- }
  -- require('lspconfig')['rust_analyzer'].setup{
  --     on_attach = on_attach,
  --     flags = lsp_flags,
  --     -- Server-specific settings...
  --     settings = {
  --       ["rust-analyzer"] = {}
  --     }
  -- }
  lspconfig.rust_analyzer.setup {
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
    end,
    flags = lsp_flags,
    capabilities = capabilities,
    settings = {
      ["rust-analyzer"] = {
        cargo = {
          loadOutDirsFromCheck = true,
          allFeatures = true,
        },
      },
    },
  }

  lspconfig.denols.setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    init_options = {
      enable = true,
      unstable = true,
    },
    root_dir = util.root_pattern("deno.json", "deno.jsonc"),
  }

  local vue_language_server_path = require("mason-registry").get_package("vue-language-server"):get_install_path()
      .. "/node_modules/@vue/language-server"

  lspconfig.tsserver.setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    root_dir = util.root_pattern("package.json", "tsconfig.json", "jsconfig.json"),
    single_file_support = false,
    init_options = {
      plugins = {
        {
          name = "@vue/typescript-plugin",
          location = vue_language_server_path,
          languages = { "vue" },
        },
      },
    },
  }

  lspconfig.volar.setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    init_options = {
      vue = {
        hybridMode = false,
      },
    },
  }

  local prettier = {
    formatCommand = 'prettierd "${INPUT}"',
    formatStdin = true,
    env = {
      string.format(
        "PRETTIERD_DEFAULT_CONFIG=%s",
        vim.fn.expand "~/.config/nvim/utils/linter-config/.prettierrc.json"
      ),
    },
  }

  lspconfig.efm.setup {
    init_options = {
      documentFormatting = true,
    },
    settings = {
      rootMarkers = { ".git/" },
      languages = {
        typescript = { prettier },
      },
    },
  }

  lspconfig.lua_ls.setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
        },
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
        },
        telemetry = {
          enable = false,
        },
      },
    },
  }

  lspconfig.clangd.setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
  }

  lspconfig.csharp_ls.setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
  }

  lspconfig.lemminx.setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
  }

  lspconfig.zls.setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    root_dir = util.root_pattern "build.zig",
  }

  lspconfig.kotlin_language_server.setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
  }

  lspconfig.texlab.setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    settings = {
      texlab = {
        forwardSearch = {
          executable = "okular",
          args = { "--unique", "file:%p#src:%l%f" },
        },
        build = {
          executable = "pdflatex",
          args = { "-interaction=nonstopmode", "-synctex=1", "%f" },
          onSave = true,
          -- forwardSearchAfter = true,
        },
      },
    },
  }

  local cmd = { "ngserver", "--stdio", "--tsProbeLocations", "node_modules", "--ngProbeLocations", "node_modules" }

  lspconfig.angularls.setup {}
end
return M
