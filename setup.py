#!/usr/bin/env python3
import os
import re
import shutil
import subprocess
import sys
import tomllib
from pathlib import Path


DOTFILES_DIR = Path(__file__).resolve().parent
MANIFEST = DOTFILES_DIR / "dotfiles.toml"
CONFIG_DIR = Path.home() / ".config"
LOCAL_BIN = Path.home() / ".local" / "bin"


def run(command: list[str]) -> None:
    subprocess.run(command, check=True)


def command_exists(command: str) -> bool:
    return shutil.which(command) is not None


def expand_path(path: str) -> Path:
    return Path(os.path.expandvars(os.path.expanduser(path)))


def parse_version(version: str) -> tuple[int, ...]:
    parts = re.findall(r"\d+", version)
    return tuple(int(part) for part in parts)


def version_ge(actual: str, required: str) -> bool:
    actual_parts = parse_version(actual)
    required_parts = parse_version(required)
    length = max(len(actual_parts), len(required_parts))
    return actual_parts + (0,) * (length - len(actual_parts)) >= required_parts + (0,) * (length - len(required_parts))


def installed_version(binary: str) -> str | None:
    if not command_exists(binary):
        return None

    result = subprocess.run([binary, "--version"], check=True, capture_output=True, text=True)
    match = re.search(r"\d+(?:\.\d+)+", result.stdout)
    return match.group(0) if match else None


def ensure_cargo_bins(cargo_bins: dict[str, str]) -> None:
    if not cargo_bins:
        return

    if not command_exists("cargo"):
        raise RuntimeError("Missing dependency: cargo")

    if not command_exists("cargo-binstall"):
        run(["cargo", "install", "cargo-binstall"])

    for binary, required_version in cargo_bins.items():
        actual_version = installed_version(binary)
        if actual_version is not None and version_ge(actual_version, required_version):
            print(f"Already installed: {binary} {actual_version}")
            continue

        print(f"Installing: {binary} {required_version}")
        run(["cargo", "binstall", "-y", "--force", f"{binary}@{required_version}"])


def ensure_symlink(source: str, destination: str) -> None:
    source_path = DOTFILES_DIR / source
    destination_path = expand_path(destination)

    if not source_path.exists():
        raise RuntimeError(f"Missing symlink source: {source_path}")

    destination_path.parent.mkdir(parents=True, exist_ok=True)

    if destination_path.exists() and destination_path.samefile(source_path):
        print(f"Already linked: {destination_path} -> {source_path}")
        return

    if destination_path.is_symlink() or not destination_path.exists():
        destination_path.unlink(missing_ok=True)
    else:
        raise RuntimeError(f"Refusing to overwrite non-symlink path: {destination_path}")

    destination_path.symlink_to(source_path, target_is_directory=source_path.is_dir())
    print(f"Linked: {destination_path} -> {source_path}")


def config_destination(source: str, destination: str | bool) -> Path:
    if destination is True:
        return CONFIG_DIR / source
    if isinstance(destination, str):
        return CONFIG_DIR / destination
    raise RuntimeError(f"Invalid config link destination for {source}: {destination!r}")


def bin_destination(source: str, destination: str | bool) -> Path:
    if destination is True:
        return LOCAL_BIN / Path(source).name
    if isinstance(destination, str):
        return LOCAL_BIN / destination
    raise RuntimeError(f"Invalid bin link destination for {source}: {destination!r}")


def ensure_links(links: dict[str, dict[str, str | bool]]) -> None:
    for source, destination in links.get("config", {}).items():
        ensure_symlink(source, str(config_destination(source, destination)))

    for source, destination in links.get("bin", {}).items():
        ensure_symlink(source, str(bin_destination(source, destination)))


def main() -> int:
    with MANIFEST.open("rb") as manifest_file:
        manifest = tomllib.load(manifest_file)

    ensure_cargo_bins(manifest.get("bins", {}).get("cargo", {}))

    ensure_links(manifest.get("links", {}))

    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except Exception as error:
        print(f"setup failed: {error}", file=sys.stderr)
        raise SystemExit(1)
