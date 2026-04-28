# Dotfiles

Personal dotfiles managed through a small manifest-driven setup script.

## Setup

Run:

```sh
~/.dotfiles/setup.sh
```

The setup script reads `dotfiles.toml`, installs required binaries, and creates symlinks for config files and helper scripts.

## Manifest

`dotfiles.toml` is the source of truth.

```toml
[bins.cargo]
zellij = "0.44.1"

[links.config]
"zellij/config.kdl" = true
"zellij/layouts" = true

[links.bin]
"zellij/bin/agentic-coding-tab" = true
```

Sections:

- `[bins.cargo]` installs Rust binaries with `cargo-binstall`. If this section is non-empty, `cargo-binstall` is installed automatically when missing.
- `[links.config]` links files or directories into `~/.config`.
- `[links.bin]` links executable helper scripts into `~/.local/bin`.

For links, `true` derives the destination automatically:

- config links preserve the source path under `~/.config`
- bin links use the source basename under `~/.local/bin`
