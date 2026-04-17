{ inputs, self, ... }: {
        perSystem = { pkgs, ... }: {
                packages.otter-launcher = inputs.wrappers.lib.wrapPackage {
                        inherit pkgs;
                        package = inputs.otter-launcher.packages.${pkgs.stdenv.hostPlatform.system}.otter-launcher;
                        runtimeInputs = [
                                self.packages.${pkgs.stdenv.hostPlatform.system}.fsel
                                pkgs.coreutils
                                pkgs.bash
                                pkgs.nh
                                pkgs.fzf
                        ];

                        preHook = ''
                                if [[ -d "$HOME/.config/otter-launcher" ]]; then
                                        mv "$HOME/.config/otter-launcher" "$HOME/.config/otter-launcher.bak"
                                fi
                                mkdir -p "$HOME/.config/otter-launcher/"
                                ln -s ${toString ./config.toml} "$HOME/.config/otter-launcher/config.toml"
                        '';

                        postHook = ''
                                rm -rf "$HOME/.config/otter-launcher"
                                if [[ -d "$HOME/.config/otter-launcher.bak" ]]; then
                                        mv "$HOME/.config/otter-launcher.bak" "$HOME/.config/otter-launcher"
                                fi
                        '';
                };
        };
}
