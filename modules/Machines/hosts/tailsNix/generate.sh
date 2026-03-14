#!/usr/bin/env bash

nix run nixpkgs#nixos-generators -- --format iso --flake ../../../..#tailsNix -o result
