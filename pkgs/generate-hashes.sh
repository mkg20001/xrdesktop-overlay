#!/bin/bash

SHELL_VERSION="3.36.0"
# SHELL_VERSION=$(nix eval "(import <nixpkgs> {}).gnome3.gnome-shell.version" | sed "s|\"||g")
XRDESKTOP_VERSION=$(cat "version.nix" | sed "s|\"||g")
BRANCH="$SHELL_VERSION-xrdesktop-$XRDESKTOP_VERSION"

HASH_EXTENSION=$(nix-prefetch-git https://gitlab.freedesktop.org/xrdesktop/gnome-shell-extension-xrdesktop "$BRANCH" --fetch-submodules | jq .sha256)
HASH_PATCHED=$(nix-prefetch-git https://gitlab.freedesktop.org/xrdesktop/gnome-shell "$BRANCH" --fetch-submodules | jq .sha256)

echo "{
  extension = $HASH_EXTENSION;
  patched = $HASH_PATCHED;
}" > hashes.nix
