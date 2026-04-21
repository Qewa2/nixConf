#!/usr/bin/env bash

FILE="${BASH_SOURCE}"
DIR="$(dirname $FILE)"
RESULT="$DIR/result"

rm -rf "$RESULT"

nix run nixpkgs#nixos-generators -- --format iso --flake "$DIR"/../../../..#tailsNix -o "$RESULT"
