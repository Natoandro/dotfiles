
require('nvim-tree').setup({
  view = {
    adaptive_size = true,
    number = true,
    relativenumber = true,
    centralize_selection = true,
    width = 40,
  }
})

require('telescope').setup{
  defaults = {
    mappings = {}
  }
}

require('trouble').setup {

}


