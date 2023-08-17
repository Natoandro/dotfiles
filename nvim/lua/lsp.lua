local M = {}

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local on_attach = function(client, bufnr)
  require("lsp-format").on_attach(client)

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
  vim.keymap.set("n", "<leader>F", function()
    vim.lsp.buf.format({ async = true })
  end, bufopts)

  local builtin = require("telescope.builtin")
  vim.keymap.set("n", "<leader>fr", builtin.lsp_references, bufopts)
  vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, bufopts)
  vim.keymap.set("n", "<leader>fS", builtin.lsp_workspace_symbols, bufopts)
  vim.keymap.set("n", "<leader>fd", builtin.diagnostics)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

local util = require("lspconfig").util

M.setup = function()
  -- require("lspconfig")["pyright"].setup({
  --   on_attach = on_attach,
  --   capabilities = capabilities,
  --   flags = lsp_flags,
  --   filetypes = { "python" },
  --   root_dir = util.root_pattern("pyproject.toml"),
  -- })

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
  require("lspconfig").rust_analyzer.setup({
    on_attach = on_attach,
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
  })

  require("lspconfig").denols.setup({
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    init_options = {
      enable = true,
      unstable = true,
    },
    root_dir = util.root_pattern("deno.json", "src/"),
  })

  require("lspconfig").lua_ls.setup({
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
  })

  require("lspconfig").clangd.setup({
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
  })

  require("lspconfig").csharp_ls.setup({
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
  })

  require("lspconfig").lemminx.setup({
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
  })

  require("lspconfig").zls.setup({
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    root_dir = util.root_pattern("build.zig"),
  })

  require("lspconfig").kotlin_language_server.setup({
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
  })

  require("lspconfig").texlab.setup({
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
  })
end

return M
