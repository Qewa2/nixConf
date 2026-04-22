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
                                pkgs.wiremix
                        ];

                        flags = {
                                "--config" = toString ./config.toml;
                        };
                };
        };
}
