#!/usr/bin/env bash

FILE="${BASH_SOURCE}"
DIR="$(dirname $FILE)"

nix run nixpkgs#nixos-generators -- --format iso --flake "$DIR"/../../../..#tailsNix -o "$DIR"/result
