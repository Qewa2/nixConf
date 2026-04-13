{ inputs, self, ... }: {
        perSystem = { pkgs, ... }: {
                packages.otter-launcher = inputs.wrappers.lib.wrapPackage {
                        inherit pkgs;
                        package = inputs.otter-launcher.packages.${pkgs.stdenv.hostPlatform.system}.otter-launcher;
                        runtimeInputs = [
                                self.packages.${pkgs.stdenv.hostPlatform.system}.fsel
                                pkgs.coreutils
                                pkgs.nh
                        ];

                        preHook = ''
                                rm -rf "$HOME/.config/otter-launcher/"
                                mkdir -p "$HOME/.config/otter-launcher/"
                                ln -s ${toString ./config.toml} "$HOME/.config/otter-launcher/config.toml"
                        '';
                };
        };
}
