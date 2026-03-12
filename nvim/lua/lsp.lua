local M = {}

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local function configure_formatting(client, bufnr)
    -- prefer 'biome' for JS/TS family, otherwise prefer null-ls if present
    local js_like = {
        javascript = true,
        typescript = true,
        javascriptreact = true,
        typescriptreact = true,
        tsx = true,
        jsx = true,
    }

    local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
    local clients = vim.lsp.get_clients { bufnr = bufnr }
    local has_null_ls, has_biome = false, false
    local biome_client, null_client
    for _, active in ipairs(clients) do
        if active.name == "null-ls" then
            has_null_ls = true
            null_client = active
        elseif active.name == "biome" then
            has_biome = true
            biome_client = active
        end
    end

    local prefer_biome = js_like[ft]

    if prefer_biome and has_biome then
        -- attach formatting to biome and disable others
        require("lsp-format").on_attach(biome_client)
        for _, active in ipairs(clients) do
            if active.id ~= biome_client.id then
                active.server_capabilities.documentFormattingProvider = false
                active.server_capabilities.documentRangeFormattingProvider = false
            end
        end
        return
    end

    if has_null_ls then
        -- use null-ls (none-ls) as the formatter for all filetypes unless biome rule applied
        require("lsp-format").on_attach(null_client)
        for _, active in ipairs(clients) do
            if active.id ~= null_client.id then
                active.server_capabilities.documentFormattingProvider = false
                active.server_capabilities.documentRangeFormattingProvider = false
            end
        end
        return
    end

    -- fallback: if no null-ls and no biome preference, attach lsp-format to the current client
    if client.server_capabilities.documentFormattingProvider then
        require("lsp-format").on_attach(client)
    end
end

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
	configure_formatting(client, bufnr)
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
	vim.keymap.set("n", "g.", vim.lsp.buf.code_action, bufopts)
    vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, bufopts)
    -- avoid shadowing the Ex command :cd (change directory)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
	-- vim.keymap.set("n", "<leader>FF", function()
	-- 	-- vim.lsp.buf.format({ async = true })
	-- 	vim.lsp.buf.format()
	-- end, bufopts)

	local builtin = require "telescope.builtin"
	vim.keymap.set("n", "<leader>fr", builtin.lsp_references, bufopts)
	vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, bufopts)
	vim.keymap.set("n", "<leader>fS", builtin.lsp_workspace_symbols, bufopts)
	vim.keymap.set("n", "<leader>fd", builtin.diagnostics)

	if client.server_capabilities.inlayHintProvider then
		vim.lsp.inlay_hint(bufnr, true)
	end
end

local lsp_flags = {
	-- This is the default in Nvim 0.7+
	debounce_text_changes = 150,
}

local util = require "lspconfig.util"

local function root_pattern(...)
	local pattern = util.root_pattern(...)
	return function(bufnr, on_dir)
		local fname = vim.api.nvim_buf_get_name(bufnr)
		on_dir(pattern(fname))
	end
end

M.setup = function()
	require("neoconf").setup {}

	vim.lsp.config("pyright", {
		on_attach = on_attach,
		capabilities = capabilities,
		flags = lsp_flags,
		filetypes = { "python" },
		-- root_dir = util.root_pattern("pyproject.toml"),
		root_dir = root_pattern "poetry.lock",
	})

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

	-- require('lspconfig')['ts_ls'].setup{
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
	vim.lsp.config("rust_analyzer", {
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
	})

	vim.lsp.config("denols", {
		on_attach = on_attach,
		flags = lsp_flags,
		capabilities = capabilities,
		init_options = {
			enable = true,
			unstable = true,
		},
		root_dir = root_pattern("deno.json", "deno.jsonc"),
	})

	-- local vue_language_server_path = require("mason-registry").get_package("vue-language-server"):get_install_path()
	--     .. "/node_modules/@vue/language-server"

	vim.lsp.config("ts_ls", {
		on_attach = on_attach,
		flags = lsp_flags,
		capabilities = capabilities,
		root_dir = root_pattern("package.json", "tsconfig.json", "jsconfig.json"),
		single_file_support = false,
		init_options = {
			plugins = {
				-- {
				--   name = "@vue/typescript-plugin",
				--   location = vue_language_server_path,
				--   languages = { "vue" },
				-- },
			},
		},
	})

	vim.lsp.config("svelte", {
		on_attach = on_attach,
		flags = lsp_flags,
		capabilities = capabilities,
	})

	vim.lsp.config("volar", {
		on_attach = on_attach,
		flags = lsp_flags,
		capabilities = capabilities,
		init_options = {
			vue = {
				hybridMode = false,
			},
		},
	})

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

	-- lspconfig.efm.setup {
	-- 	init_options = {
	-- 		documentFormatting = true,
	-- 	},
	-- 	settings = {
	-- 		rootMarkers = { ".git/" },
	-- 		languages = {
	-- 			typescript = { prettier },
	-- 		},
	-- 	},
	-- }

	vim.lsp.config("lua_ls", {
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

	vim.lsp.config("clangd", {
		on_attach = on_attach,
		flags = lsp_flags,
		capabilities = capabilities,
	})

	vim.lsp.config("csharp_ls", {
		on_attach = on_attach,
		flags = lsp_flags,
		capabilities = capabilities,
	})

	vim.lsp.config("lemminx", {
		on_attach = on_attach,
		flags = lsp_flags,
		capabilities = capabilities,
	})

	vim.lsp.config("zls", {
		on_attach = on_attach,
		flags = lsp_flags,
		capabilities = capabilities,
		root_dir = root_pattern "build.zig",
	})

	vim.lsp.config("kotlin_language_server", {
		on_attach = on_attach,
		flags = lsp_flags,
		capabilities = capabilities,
	})

	vim.lsp.config("texlab", {
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

	vim.lsp.config("biome", {})
	vim.lsp.config("angularls", {})
	vim.lsp.config("gopls", {})

	for _, server in ipairs({
		"pyright",
		"rust_analyzer",
		"denols",
		"ts_ls",
		"svelte",
		"volar",
		"lua_ls",
		"clangd",
		"csharp_ls",
		"lemminx",
		"zls",
		"kotlin_language_server",
		"texlab",
		"biome",
		"angularls",
		"gopls",
	}) do
		vim.lsp.enable(server)
	end
end
return M
