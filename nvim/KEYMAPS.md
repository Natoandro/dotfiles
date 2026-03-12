Keymaps & Upstream Defaults
===========================

This file collects verbatim upstream "default mappings / commands" excerpts for key plugins and a short fetch status log for README pulls.
Tables are used where helpful to present mappings in a compact, readable form.

Telescope (nvim-telescope/telescope.nvim)
-----------------------------------------
| Key/Command | Description |
|-------------|-------------|
| `:Telescope find_files` | Open file picker |
| `:Telescope live_grep` | Live grep in project |
| `:Telescope buffers` | List open buffers |
| `<C-n>` / `<Down>` | Next item (insert mode) |
| `<C-p>` / `<Up>` | Previous item (insert mode) |
| `<CR>` | Confirm selection |
| `<C-x>` | Open in horizontal split |
| `<C-v>` | Open in vertical split |
| `<C-t>` | Open in new tab |
| `<C-q>` | Send to quickfix |
| `<C-/>` | Show picker actions |

Overrides
| Key | Local Mapping |
|-----|---------------|
| `<leader>ff` | `require('telescope.builtin').find_files` |
| `<leader>fg` | `require('telescope.builtin').live_grep` |
| `<leader>tb` | `require('telescope.builtin').buffers` |
| `<leader>th` | `require('telescope.builtin').help_tags` |
| `<leader>tt` | `require('telescope.builtin').treesitter` |
| `<leader>fb` | `:Telescope file_browser path=%:p:h select_buffer=true hidden=true<CR>` |

nvim-tree.lua (nvim-tree/nvim-tree.lua)
-------------------------------------
| Key/Command | Description |
|-------------|-------------|
| `:NvimTreeToggle` | Toggle file tree |
| `:NvimTreeFindFile` | Reveal current file |
| `:NvimTreeRefresh` | Refresh tree |
| `:NvimTreeOpen` | Open tree |
| `<CR>` / `o` | Open file |
| `s` | Open in split |
| `v` | Open in vsplit |
| `t` | Open in new tab |
| `a` | Create file |
| `d` | Delete file |
| `g?` | Show mappings/help |

Overrides
| Key | Local Mapping |
|-----|---------------|
| `<C-n>` | `:NvimTreeToggle<CR>` (toggle file tree) |

gitsigns.nvim (lewis6991/gitsigns.nvim)
-------------------------------------
| Key/Command | Description |
|-------------|-------------|
| `:Gitsigns stage_hunk` | Stage current hunk |
| `:Gitsigns reset_hunk` | Reset current hunk |
| `:Gitsigns preview_hunk` | Preview hunk |
| `:Gitsigns blame_line` | Blame current line |
| `:Gitsigns setqflist` | Send hunks to qf |
| `]c` / `[c` | Next / previous hunk |
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hp` | Preview hunk |
| `<leader>hb` | Blame line |
| `<leader>tb` | Toggle blame |

-- Lualine (local buffer jumps)
| Key | Local Mapping |
|-----|---------------|
| `<leader>1..9` | `:LualineBuffersJump! N<CR>` (buffer jump via lualine plugin) |

harpoon (ThePrimeagen/harpoon)
-----------------------------
| Key / API | Description |
|-----------|-------------|
| `require('harpoon.mark').add_file()` | Add current file to marks |
| `require('harpoon.ui').toggle_quick_menu()` | Toggle quick menu |
| `require('harpoon.ui').nav_next()` | Next mark |
| `require('harpoon.ui').nav_prev()` | Previous mark |
| `require('harpoon.ui').nav_file(index)` | Jump to mark by index |
| `<leader>hm` / `<leader>a` | Add file (common mapping) |
| `<leader>hh` | Toggle menu |
| `<leader>1..9` | Jump to marks 1..9 |
| `<leader>hn` / `<leader>hp` | Cycle next / prev |

Overrides
| Key | Local Mapping |
|-----|---------------|
| `<leader>hh` | `require('harpoon.ui').toggle_quick_menu` |
| `<leader>hm` | `require('harpoon.mark').add_file` |
| `<leader>hp` | `require('harpoon.ui').nav_prev` |
| `<leader>hn` | `require('harpoon.ui').nav_next` |

Comment.nvim (numToStr/Comment.nvim)
-----------------------------------
| Mode | Key | Description |
|------|-----|-------------|
| NORMAL | `gcc` | Toggle current line comment |
| NORMAL | `gbc` | Toggle block comment |
| NORMAL | `gc{motion}` | Operator-pending comment |
| VISUAL | `gc` | Comment selection |
| VISUAL | `gb` | Block comment selection |
| NORMAL | `gco` | Comment below |
| NORMAL | `gcO` | Comment above |
| NORMAL | `gcA` | Comment end of line |

Overrides
| Mode | Key | Local Mapping |
|------|-----|---------------|
| NORMAL | `<leader>/` | `:CommentToggle<CR>` |
| VISUAL | `<leader>/` | `:CommentToggle<CR>` |

nvim-surround (kylechui/nvim-surround)
-------------------------------------
| Command | Description |
|---------|-------------|
| `ys{motion}{char}` | Add surround |
| `ds{char}` | Delete surround |
| `cs{old}{new}` | Change surround |
| `S` (visual) | Surround selection |

Fetch Log
---------
| Plugin | Resolved Raw URL |
|--------|------------------|
| neovim/nvim-lspconfig | https://raw.githubusercontent.com/neovim/nvim-lspconfig/master/README.md |
| zbirenbaum/copilot-cmp | https://raw.githubusercontent.com/zbirenbaum/copilot-cmp/master/README.md |
| hrsh7th/cmp-nvim-lsp | https://raw.githubusercontent.com/hrsh7th/cmp-nvim-lsp/main/README.md |
| numToStr/Comment.nvim | https://raw.githubusercontent.com/numToStr/Comment.nvim/master/README.md |
| kylechui/nvim-surround | https://raw.githubusercontent.com/kylechui/nvim-surround/master/README.md |
| ThePrimeagen/harpoon | https://raw.githubusercontent.com/ThePrimeagen/harpoon/master/README.md |
| nvim-lualine/lualine.nvim | https://raw.githubusercontent.com/nvim-lualine/lualine.nvim/master/README.md |
| ojroques/nvim-osc52 | https://raw.githubusercontent.com/ojroques/nvim-osc52/master/README.md |

Inserted Excerpts
-----------------
<!-- nvim-lspconfig excerpt -->
| Key / Command | Description |
|---------------|-------------|
| `:LspInfo` | Show status of active and configured language servers |
| `:lsp enable [<config_name>]` | Enable server config (Nvim 0.11+ API) |
| `:lsp disable [<config_name>]` | Disable server |

Excerpt source: https://raw.githubusercontent.com/neovim/nvim-lspconfig/master/README.md

<!-- copilot-cmp excerpt -->
| Key / Snippet | Description |
|---------------|-------------|
| `cmp.setup { sources = { { name = "copilot" } } }` | Add copilot as a cmp source |
| Tab completion helpers | Example `has_words_before()` helper and mapping snippet provided in README |

Excerpt source: https://raw.githubusercontent.com/zbirenbaum/copilot-cmp/master/README.md

<!-- cmp-nvim-lsp excerpt -->
| Concept | Note |
|--------|------|
| `require('cmp_nvim_lsp').default_capabilities()` | Helper to augment LSP client capabilities for nvim-cmp |
| Example config snippet | README shows example usage with `lspconfig` to pass capabilities to servers |

Excerpt source: https://raw.githubusercontent.com/hrsh7th/cmp-nvim-lsp/main/README.md

Notes
-----
- The overrides are now placed directly below each plugin's upstream table for easy cross-reference.
- If you want me to expand any plugin section with larger verbatim README blocks (examples or usage snippets), tell me which plugin(s) and I'll append them.

Expanded README excerpts
------------------------
Below are larger verbatim excerpts (mapping/commands/usage/setup snippets) pulled from each plugin's README for quick reference.

Telescope — Default mappings & usage
------------------------------------
From: https://raw.githubusercontent.com/nvim-telescope/telescope.nvim/master/README.md

Default Mappings (verbatim):

| Mappings       | Action                                                    |
| -------------- | --------------------------------------------------------- |
| `<C-n>/<Down>` | Next item                                                 |
| `<C-p>/<Up>`   | Previous item                                             |
| `j/k`          | Next/previous (in normal mode)                            |
| `H/M/L`        | Select High/Middle/Low (in normal mode)                   |
| `gg/G`         | Select the first/last item (in normal mode)               |
| `<CR>`         | Confirm selection                                         |
| `<C-x>`        | Go to file selection as a split                           |
| `<C-v>`        | Go to file selection as a vsplit                          |
| `<C-t>`        | Go to a file in a new tab                                 |
| `<C-u>`        | Scroll up in preview window                               |
| `<C-d>`        | Scroll down in preview window                             |
| `<C-f>`        | Scroll left in preview window                             |
| `<C-k>`        | Scroll right in preview window                            |
| `<M-f>`        | Scroll left in results window                             |
| `<M-k>`        | Scroll right in results window                            |
| `<C-/>`        | Show mappings for picker actions (insert mode)            |
| `?`            | Show mappings for picker actions (normal mode)            |
| `<C-c>`        | Close telescope (insert mode)                             |
| `<Esc>`        | Close telescope (in normal mode)                          |
| `<Tab>`        | Toggle selection and move to next selection               |
| `<S-Tab>`      | Toggle selection and move to prev selection               |
| `<C-q>`        | Send all items not filtered to quickfixlist (qflist)      |
| `<M-q>`        | Send all selected items to qflist                         |

Use the `setup()` API to customize mappings per picker or globally.


nvim-tree.lua — Quick start & custom mappings
---------------------------------------------
From: https://raw.githubusercontent.com/nvim-tree/nvim-tree.lua/master/README.md

Quick Start (verbatim snippets):

Example minimal setup:

```lua
  -- disable netrw at the very start of your init.lua
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1

  -- optionally enable 24-bit colour
  vim.opt.termguicolors = true

  -- empty setup using defaults
  require("nvim-tree").setup()
```

Custom mappings (on_attach example):

```lua
  local function my_on_attach(bufnr)
    local api = require "nvim-tree.api"

    local function opts(desc)
      return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- default mappings
    api.map.on_attach.default(bufnr)

    -- custom mappings
    vim.keymap.set("n", "<C-t>", api.tree.change_root_to_parent,        opts("Up"))
    vim.keymap.set("n", "?",     api.tree.toggle_help,                  opts("Help"))
  end

  require("nvim-tree").setup({ on_attach = my_on_attach })
```

Commands (examples): `:NvimTreeToggle`, `:NvimTreeFindFile`, `:NvimTreeRefresh`, `:NvimTreeOpen`.


gitsigns.nvim — Keymaps (on_attach example)
-------------------------------------------
From: https://raw.githubusercontent.com/lewis6991/gitsigns.nvim/master/README.md

The README provides an `on_attach` example that registers suggested buffer-local mappings:

```lua
require('gitsigns').setup{
  on_attach = function(bufnr)
    local gitsigns = require('gitsigns')

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal({']c', bang = true})
      else
        gitsigns.nav_hunk('next')
      end
    end)

    map('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal({'[c', bang = true})
      else
        gitsigns.nav_hunk('prev')
      end
    end)

    -- Actions
    map('n', '<leader>hs', gitsigns.stage_hunk)
    map('n', '<leader>hr', gitsigns.reset_hunk)
    map('v', '<leader>hs', function()
      gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end)
    map('n', '<leader>hp', gitsigns.preview_hunk)
    map('n', '<leader>hb', function() gitsigns.blame_line({ full = true }) end)

    -- Toggles
    map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
  end
}
```


LuaSnip — Keymaps & setup notes
-------------------------------
From: https://raw.githubusercontent.com/L3MON4D3/LuaSnip/master/README.md

Keymaps examples (verbatim):

Vimscript example for Tab-based expansion/jumping:

```vim
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
inoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<CR>
snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<CR>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<CR>
```

Lua example (Ctrl-key based):

```lua
local ls = require("luasnip")
vim.keymap.set({"i"}, "<C-K>", function() ls.expand() end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-L>", function() ls.jump( 1) end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-J>", function() ls.jump(-1) end, {silent = true})
```

Note: LuaSnip optionally builds `jsregexp` via `make install_jsregexp` for better LSP snippet transformations.


nvim-cmp — Recommended configuration
-----------------------------------
From: https://raw.githubusercontent.com/hrsh7th/nvim-cmp/master/README.md

Recommended setup snippet (verbatim):

```lua
local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  })
})
```


nvim-lspconfig — Important notes & Quickstart
--------------------------------------------
From: https://raw.githubusercontent.com/neovim/nvim-lspconfig/master/README.md

Important (verbatim):

* `require('lspconfig')` (the legacy "framework" of nvim-lspconfig) is deprecated in favor of `vim.lsp.config` (Nvim 0.11+). Use `vim.lsp.config('name', {...})` to define/extend and `vim.lsp.enable('name')` to enable.

Quickstart example (verbatim):

```bash
npm i -g pyright
```

Then in init.lua:

```lua
vim.lsp.enable('pyright')
```

Useful commands from README: `:LspInfo`, `:lsp enable [<config_name>]`, `:lsp disable [<config_name>]`.


copilot-cmp — Setup & tab completion advice
------------------------------------------
From: https://raw.githubusercontent.com/zbirenbaum/copilot-cmp/master/README.md

Setup example (verbatim):

```lua
{
  "zbirenbaum/copilot-cmp",
  config = function ()
    require("copilot_cmp").setup()
  end
}
```

Tab completion configuration guidance (verbatim):

```lua
local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
end
cmp.setup({
  mapping = {
    ["<Tab>"] = vim.schedule_wrap(function(fallback)
      if cmp.visible() and has_words_before() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
      else
        fallback()
      end
    end),
  },
})
```


cmp-nvim-lsp — Capabilities helper
----------------------------------
From: https://raw.githubusercontent.com/hrsh7th/cmp-nvim-lsp/main/README.md

Excerpt (verbatim):

Use `require('cmp_nvim_lsp').default_capabilities()` to augment LSP client capabilities so servers can provide richer completion items for nvim-cmp. Example:

```lua
local capabilities = require('cmp_nvim_lsp').default_capabilities()
vim.lsp.config('clangd', { capabilities = capabilities })
vim.lsp.enable('clangd')
```
