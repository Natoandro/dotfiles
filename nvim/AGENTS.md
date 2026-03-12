AGENTS
======

Purpose
-------
This file documents how automated agents (and humans acting as agents) should build, lint, test,
and modify this Neovim configuration repository. It also codifies style and operational
conventions so agents produce consistent, maintainable changes.

Repository notes
----------------
- This repo is a Neovim configuration (Lua) located at the repository root. Primary Lua
  modules live under `lua/` and plugin specifications under `lua/plugins/*.lua`.
- Key config files: `init.lua`, `lua/lsp.lua`, `lua/keymaps.lua`, `lua/plugins/*.lua`.
- This repo is not a library — changes should be conservative and preserve user workflows.

Quick operational commands
--------------------------
- Open Neovim with this config (useful for manual checks):
  - `nvim --cmd 'set rtp^=$PWD'`  (run from the repo root)

- Install / update plugins (Lazy.nvim):
  - Interactive: open Neovim and run `:Lazy sync` then `:Lazy clean`.
  - Headless (CI):
    - `nvim --headless -c "lua require('lazy').sync()" -c qa`

- Run Neovim health checks:
  - Open Neovim and run `:checkhealth` (or headless `nvim --headless -c 'checkhealth' -c qa`).

- Build native extensions (example: telescope-fzf-native):
  - Usually handled by Lazy's `build` step. If manual: `make` in the plugin folder,
    e.g. `~/.local/share/nvim/lazy/telescope-fzf-native.nvim && make`.

Lint / format / static checks
-----------------------------
Recommended tools (these are not required by the repo but recommended for agents):

- stylua (Lua formatter)
  - Format the entire repo: `stylua .`
  - Configuration: prefer 2-space indentation, align tables minimally, keep line widths
    conservative (80-120). If a `.stylua.toml` is added, use that. Agents must run
    `stylua` before committing formatting changes.

- luacheck (optional static linter)
  - Install and run: `luacheck lua/`.
  - Use `.luacheckrc` if added to ignore intentionally global variables created by Neovim.

- busted / plenary test harness (if tests are added)
  - If tests use `busted`: run a single test file: `busted path/to/test_file.lua` or
    a single test with a pattern: `busted -p "Test name pattern" path/to/test_file.lua`.
  - If tests use `plenary` (Neovim test harness): run from inside Neovim:
    - Single file interactively: `:PlenaryBustedFile path/to/test_file.lua`
    - Headless (example):
      `nvim --headless -c "PlenaryBustedFile path/to/test_file.lua" -c qa`

Running a single test (recommended order)
-----------------------------------------
1. Prefer running tests interactively the first time to inspect output: open Neovim and
   run `:PlenaryBustedFile path/to/test_file.lua`.
2. For CI/headless, use `nvim --headless -c "PlenaryBustedFile path/to/test_file.lua" -c qa`.
3. If the project uses `busted` directly, run `busted path/to/test_file.lua`.

Code style guidelines (for agents)
----------------------------------
General
- Keep changes minimal and well-scoped. Small, focused commits are preferred.
- Use ASCII in files unless a compelling reason exists and the file already contains
  non-ASCII characters.

Lua specifics
- Indentation: 2 spaces. Align table entries and function arguments for readability.
- Files and modules: use snake_case for file names and module namespaces (e.g.
  `lua/plugins/telescope.lua` exposes `require('plugins.telescope')`).
- Variables & functions:
  - Use `local` for all module-level variables and functions to avoid polluting the
    global namespace.
  - Prefer `snake_case` for local variables and functions. Use `PascalCase` for module
    tables when appropriate (e.g. `M = {}` in a module file) and `camelCase` for
    closures only when it matches the surrounding style — aim for consistency.
- Requires/imports:
  - Use `local X = require('module')` at top of file.
  - For optional plugins/extensions use `local ok, mod = pcall(require, 'modname')` and
    gracefully handle absence (e.g. `if not ok then return end` or `pcall` where safe).

Formatting & style tooling
- Always run `stylua` before committing. If the repo adds a `.stylua.toml`, follow it.
- Do not commit files that are only formatting changes alongside functional changes. Separate
  formatting-only commits are acceptable when they are large and mechanically applied.

Types & annotations
- Lua in this repo is untyped but agents should add EmmyLua annotations when a function's
  contract is non-obvious. Example:

  ---@param bufnr number
  ---@return boolean
  local function has_formatter(bufnr) end

- Prefer explicit returns; keep functions small and single-responsibility.

Naming conventions
- Files: snake_case.lua
- Modules: `lua.foo.bar` -> require('foo.bar')
- Module tables: `local M = {}` then `return M` at EOF
- Locals: snake_case; upvalues/constants: UPPER_SNAKE for constants

Error handling and robustness
--------------------------------
- Use `pcall(require, ...)` for optional plugin modules. Example:
  `local ok, ext = pcall(require, 'telescope._extensions.fzf')`
  `if ok then ext.setup(...) end`
- Fail loudly for unexpected internal errors during setup using `error()` or
  `vim.notify(..., vim.log.levels.ERROR)` so the user/agent sees the issue.
- Prefer `vim.schedule` when calling API that must run on the main loop from async
  callbacks.
- Avoid global autocommands without an augroup; always create `vim.api.nvim_create_augroup`
  and clear/create buffer-local autocmds safely.

LSP / formatting conventions
----------------------------
- Use current Neovim 0.11+ APIs (avoid deprecated `nvim-lspconfig` framework calls). Use
  `vim.lsp.config` / `vim.lsp.enable` where appropriate.
- Formatting routing: prefer one router for formatters (this repo uses `none-ls` fork).
  - Disable other `textDocument/formatting` providers when the preferred formatter
    (biome/null-ls/none-ls) is present to avoid competing BufWritePre hooks.
- Use `vim.lsp.buf.format({ bufnr = bufnr, filter = function(client) ... end })` to
  select formatter clients explicitly when needed.

Plugin management conventions
-----------------------------
- Add plugins only in `lua/plugins/*.lua`. Keep each plugin definition minimal and
  prefer lazy-loading via `ft`, `cmd`, `event`, `cond`, or `keys`.
- Avoid duplicate plugin entries. If two plugin files reference the same plugin,
  consolidate to a single declaration.
- Use `build`, `cond`, and `ft` options on plugin specs to reduce startup cost.
- When adding native-build plugins (e.g., telescope-fzf-native), include a `cond`
  guard if building requires a host toolchain.

Commit & PR conventions for agents
----------------------------------
- Write small commits with clear messages (imperative tense). Example: `replace
  vim-surround with nvim-surround and add config`.
- Do not amend commits pushed to remote. If tests fail, add a new fix commit.
- When creating a PR, include:
  1) 1–3 bullet summary of the change
  2) files changed that matter
  3) any manual steps required to verify (e.g., `:Lazy sync`, `:checkhealth`)
- Documentation: When a change affects plugin list, keybindings, or public behavior, update `README.md` at the repository root to reflect the change. Agents must update `README.md` whenever a relevant change is made.
Cursor / Copilot rules
----------------------
- This repo contains no `.cursor` or `.cursorrules` directories and no
  `.github/copilot-instructions.md`. If such files are added later, agents must
  include those rules verbatim in follow-up AGENTS.md updates and obey the
  repository-level Copilot instructions during code generation.

Safe defaults for automated agents
---------------------------------
- Make a branch per task and include a short description in the branch name.
- Run `stylua` and `luacheck` locally before opening a PR. Run `:checkhealth` and
  run a quick smoke test (open Neovim and confirm basic startup completes).
- When changing LSP/formatting behavior, include instructions for manual verification
  in the PR description (which command to run and what to expect).

Example checklist for a typical change
-------------------------------------
1. Create a branch: `git checkout -b fix/replace-plugin`
2. Make code changes (follow style rules above).
3. Run `stylua .` and `luacheck lua/`.
4. Run `nvim --headless -c "lua require('lazy').sync()" -c qa` to ensure plugins install.
5. Run `nvim --headless -c 'checkhealth' -c qa` and inspect output.
6. Commit and push. Open PR with reproduction steps and manual verification notes.

Contact / escalation
--------------------
- If an automated change produces unexpected behavior that can't be fixed in a small
  follow-up commit, add a PR comment describing the failure and tag a human reviewer.

Appendix: repo-specific notes
----------------------------
- Primary plugin specs live in `lua/plugins/*.lua` — prefer edits there.
- Avoid removing theme plugins unless the user requests it (visual preference).
- Clipboard fallback uses OSC52 provider in `lua/plugins/init.lua`; test over SSH/tmux.

End
