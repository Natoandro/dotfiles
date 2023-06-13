
require('nvim-tree').setup({
  view = {
    adaptive_size = true,
    number = true,
    relativenumber = true,
    centralize_selection = true,
    width = 40,
  }
})

local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    mappings = {}
  },
  pickers = {
    buffers = {
      mappings = {
        i = {
          ["<c-x>"] = actions.delete_buffer + actions.move_to_top,
        }
      }
    }
  },
  extenstions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    }
  }
}
require('telescope').load_extension('fzf')

require('trouble').setup {

}


