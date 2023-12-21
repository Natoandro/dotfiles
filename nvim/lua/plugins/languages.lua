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
		opts = {
			ensure_installed = { "lua", "rust", "toml", "typescript", "python" },
			auto_install = true,
			highlight = {
				enable = true,
			},
			rainbow = {
				enable = true,
				extended_mod = true,
			},
		},
	},
	"nvim-treesitter/nvim-treesitter-context",

	{
		"lukas-reineke/lsp-format.nvim",
		opts = {},
	},

	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			local null_ls = require("null-ls")
			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.stylua,
					-- null_ls.builtins.diagnostics.eslint,
					null_ls.builtins.completion.spell,
					null_ls.builtins.diagnostics.mypy,
					null_ls.builtins.diagnostics.ruff,
					null_ls.builtins.formatting.black,
				},
				on_attach = function(client, bufnr)
					if client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({
							group = augroup,
							buffer = bufnr,
						})
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = augroup,
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format({ bufnr = bufnr })
							end,
						})
					end
				end,
			})
		end,
	},

	{
		"simrat39/inlay-hints.nvim",
		config = true,
	},

	"udalov/kotlin-vim",

	-- "lervag/vimtex",
	{
		"f3fora/nvim-texlabconfig",
		config = function()
			require("texlabconfig").setup()
		end,
		ft = { "tex", "bib" },
		build = "go build",
	},
}
