
require('lualine').setup({
  options = {
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_c = {
      {
        'filename',
        path = 1,
      }
    }
  },
  tabline = {
    lualine_a = {
      {
        'buffers',
        mode = 2,
      }
    },
    lualine_c = { '%=' },
    lualine_z = {'tabs'},
  },
})

