Neovim Configuration
====================

This repository contains a Neovim 0.11+ configuration (Lua) customized for a programmer-focused
workflow. It uses Lazy.nvim for plugin management and aims to prefer modern, Lua-first plugins.

Installed plugins (ordered by importance)
----------------------------------------
1. neovim/nvim-lspconfig — LSP integration and language server management (core for IDE features)
2. nvimtools/none-ls.nvim — formatting and diagnostics routing (null-ls fork; central formatter)
3. nvim-treesitter/nvim-treesitter — syntax parsing, highlighting, and incremental selection
4. hrsh7th/nvim-cmp (+ cmp sources) — completion engine (LSP + snippets + buffer)
5. L3MON4D3/LuaSnip — snippet engine used by nvim-cmp
6. telescope.nvim (+ telescope-fzf-native) — fuzzy finding and file navigation
7. lewis6991/gitsigns.nvim — git hunks and inline signs
8. nvim-lualine/lualine.nvim — statusline
9. kylechui/nvim-surround — surround text objects and motions
10. numToStr/Comment.nvim — comment toggling
11. lukas-reineke/indent-blankline.nvim — indentation guides
12. ojroques/nvim-osc52 — OSC52 clipboard fallback for remote sessions
13. zbirenbaum/copilot.lua + copilot-cmp — GitHub Copilot integration with completion
14. ray-x/go.nvim — Go tooling (if you work with Go)

Keymaps / Commands (common)
---------------------------
| Key | Mode | Command |
|-----|------|---------|
| `<C-h> / <C-j> / <C-k> / <C-l>` | Normal | Window navigation (`<C-w>h/j/k/l`) |
| `<C-n>` | Normal | Toggle NvimTree (`:NvimTreeToggle`) |
| `<leader>R` | Normal | Reload `init.lua` (`:so ~/.config/nvim/init.lua`) |
| `<leader>s` | Normal | Save buffer (`:w`) |
| `<leader>ff` | Normal | Telescope find_files |
| `<leader>fg` | Normal | Telescope live_grep |
| `<leader>tb` | Normal | Telescope buffers |
| `<leader>tt` | Normal | Telescope treesitter |
| `<leader>F` | Normal | Format buffer (`vim.lsp.buf.format`) |
| `<leader>/` | Normal/Visual | Toggle comment (Comment.nvim) |
| `<leader>1..9` | Normal | Jump to Lualine buffer slots 1..9 |
| `gh` / `gl` | Normal | Previous/Next buffer |
| `<leader>hh` | Normal | Harpoon: toggle quick menu |
| `<leader>hm` | Normal | Harpoon: add file |
| `<leader>hp` / `<leader>hn` | Normal | Harpoon: prev/next file |
| `<M-.>` / `<M-,>` | Insert | Copilot next / previous suggestion |

Notes
-----
- Keep README.md updated when you change major plugins, keymaps, or workflow behavior. The
  `AGENTS.md` requires agents to update README.md when relevant changes are made.

How to install
--------------
1. Ensure Neovim 0.11+ is installed.
2. Install a C toolchain if you want to build native extensions (e.g., `make` and a compiler).
3. Open Neovim from the repo root and run `:Lazy sync` to install plugins.

Feedback / Contributions
------------------------
If you automate changes with agents, follow `AGENTS.md` for commit, lint, and PR conventions.

Plugin documented defaults (upstream)
-----------------------------------
This section contains canonical/default commands and common example mappings taken from upstream
plugin documentation. Your config may override some of these; they are included for reference so
agents and users can quickly locate upstream defaults.

- Telescope (nvim-telescope/telescope.nvim)
  - Commands: `:Telescope find_files`, `:Telescope live_grep`, `:Telescope buffers`, `:Telescope help_tags`, `:Telescope file_browser`.
  - Default picker insert-mode keys: `<C-n>/<Down>` next, `<C-p>/<Up>` previous, `<CR>` confirm, `<C-x>` open in split, `<C-v>` open in vsplit, `<C-t>` open in new tab, `<C-q>` send to quickfix, `<C-/>` show picker actions.

- nvim-tree.lua (nvim-tree/nvim-tree.lua)
  - Commands: `:NvimTreeToggle`, `:NvimTreeFindFile`, `:NvimTreeRefresh`, `:NvimTreeOpen`.
  - Default mappings (see plugin help): `<CR>` / `o` open, `s` split, `v` vsplit, `t` new tab, `a` create, `d` delete, `g?` show mappings.

- gitsigns.nvim (lewis6991/gitsigns.nvim)
  - Commands: `:Gitsigns stage_hunk`, `:Gitsigns reset_hunk`, `:Gitsigns preview_hunk`, `:Gitsigns blame_line`, `:Gitsigns setqflist`.
  - Suggested on_attach mappings (common): `]c` / `[c` next/prev hunk; `<leader>hs` stage hunk; `<leader>hr` reset hunk; `<leader>hp` preview hunk; `<leader>hb` blame line; `<leader>tb` toggle blame.

- harpoon (ThePrimeagen/harpoon)
  - API / Commands: `require('harpoon.mark').add_file()`, `require('harpoon.ui').toggle_quick_menu()`, `require('harpoon.ui').nav_next()`, `require('harpoon.ui').nav_prev()`, `require('harpoon.ui').nav_file(index)`.
  - Common user mappings: add file (often `<leader>hm` or `<leader>a`), toggle menu `<leader>hh`, nav marks `<leader>1..9` or cycle `<leader>hn` / `<leader>hp`.

- Comment.nvim (numToStr/Comment.nvim)
  - Default mappings created by `require('Comment').setup()`:
    - NORMAL: `gcc` toggle current line comment, `gbc` toggle block comment, `gc{motion}` operator-pending comment.
    - VISUAL: `gc` comment selection, `gb` block comment selection.
    - Extras: `gco` (comment below), `gcO` (comment above), `gcA` (comment end of line).

- nvim-surround (kylechui/nvim-surround)
  - Default usage (compatible with vim-surround semantics): `ys{motion}{char}` add surround, `ds{char}` delete surround, `cs{old}{new}` change surround, visual `S` to surround selection.

Fetch plugin READMEs and verbatim mappings
-----------------------------------------
If you want verbatim default mappings for other plugins (copilot.lua, nvim-cmp, LuaSnip, lualine, etc.), I can fetch each plugin README and paste the relevant mapping tables. I will attempt multiple retries for each README and proceed plugin-by-plugin, logging failures and retrying failed ones after attempting the rest.

Tell me which plugins you want verbatim mappings for (or say `all`) and I will start fetching them and update this README accordingly.

Plugin README fetch status (current)
-----------------------------------
- **Succeeded (ready to include verbatim excerpts):** `nvimtools/none-ls.nvim`, `nvim-treesitter/nvim-treesitter`, `hrsh7th/nvim-cmp`, `L3MON4D3/LuaSnip`, `nvim-telescope/telescope.nvim`, `lewis6991/gitsigns.nvim`, `nvim-lualine/lualine.nvim`, `kylechui/nvim-surround`, `numToStr/Comment.nvim`, `lukas-reineke/indent-blankline.nvim`, `ojroques/nvim-osc52`, `zbirenbaum/copilot.lua`, `ray-x/go.nvim`, `saecki/crates.nvim`, `windwp/nvim-ts-autotag`, `williamboman/mason.nvim`, `nvimtools/none-ls-extras.nvim`, `nvim-lua/plenary.nvim`, `nvim-telescope/telescope-fzf-native.nvim`, `nvim-telescope/telescope-file-browser.nvim`, `nvim-telescope/telescope-symbols.nvim`.
- **Failed or partially fetched (will retry):** `neovim/nvim-lspconfig`, `zbirenbaum/copilot-cmp`, `hrsh7th/cmp-nvim-lsp` (some README endpoints returned 404 or timed out during attempts).

Notes:
- I attempted parallel fetches for a large set of README files. Many returned successfully and I captured their contents; a small set returned HTTP 404 or timed out from the raw GitHub URL used for fetching.
- Some plugins have moved/renamed repositories or their README raw paths differ; for those I'll retry with resilient attempts (see next steps).

Recommended next actions (I will proceed with the first one unless you instruct otherwise):
1) Retry failed README fetches up to 3 times each (recommended). After the first pass I'll do two additional focused passes for remaining failures and log final status.
2) Populate `nvim/README.md` with verbatim mapping/commands tables for every successfully fetched plugin and insert placeholders for the ones that still fail after retries.
3) If you prefer summaries instead of verbatim READMEs, tell me now — otherwise I'll insert verbatim snippets for upstream default mappings/commands and annotate overrides from `lua/keymaps.lua`.

What would change based on your choice:
- If you choose to retry (recommended), I'll perform retries now and then update this README with per-plugin verbatim tables for successes and a failure log for any remaining misses.
- If you say "proceed without retry", I'll populate the README immediately using the plugins we already fetched and leave explicit placeholders for the failed ones so you can inspect or ask for re-fetch later.

Please confirm whether you want me to retry failed fetches (recommended) or proceed to populate the README now with the current successful fetches. If you don't reply I'll retry automatically (recommended).
