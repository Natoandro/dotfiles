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
				-- choose the best available file finder (fd preferred, fallback to rg)
				find_command = (vim.fn.executable("fd") == 1) and {
					"fd",
					"--type",
					"f",
					"--hidden",
					"--follow",
					"--exclude",
					".git",
					"--exclude",
					"node_modules",
				} or {
					"rg",
					"--files",
					"--hidden",
					"--follow",
					"--glob",
					"!.git/*",
					"--glob",
					"!node_modules/*",
				},
				file_ignore_patterns = { "node_modules/", ".git/" },
				mappings = {
					i = {
						["<C-n>"] = actions.move_selection_next,
						["<C-p>"] = actions.move_selection_previous,
					},
				},
			},
				pickers = {
			find_files = {
				theme = "ivy",
				hidden = true,
				no_ignore = true,
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

            -- load fzf extension if available; pcall avoids errors when native build is missing
            pcall(require("telescope").load_extension, "fzf")
            pcall(require("telescope").load_extension, "file_browser")
        end,
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        -- only try to install/build if 'make' is available on the system
        cond = function()
            return vim.fn.executable("make") == 1
        end,
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
