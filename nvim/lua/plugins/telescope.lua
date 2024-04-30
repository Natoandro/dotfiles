return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			local actions = require("telescope.actions")

			require("telescope").setup({
				defaults = {
					mappings = {},
				},
				pickers = {
					find_files = {
						theme = "ivy",
						hidden = true,
					},
					buffers = {
						theme = "ivy",
						mappings = {
							i = {
								["<C-Del>"] = actions.delete_buffer, -- + actions.move_to_top,
							},
						},
					},
				},
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
					file_browser = {
						theme = "ivy",
						mappings = {
							["i"] = {
								["o"] = actions.select_default,
							},
						},
					},
				},
			})

			require("telescope").load_extension("fzf")
			require("telescope").load_extension("file_browser")
		end,
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
		},
	},
	{
		"nvim-telescope/telescope-symbols.nvim",
	},
}
