{ inputs, self, ... }: {
        perSystem = { pkgs, ... }: {
                packages.mango = inputs.wrappers.lib.wrapPackage {
                        inherit pkgs;
                        package = inputs.mangowm.packages.${pkgs.stdenv.hostPlatform.system}.mango;
                        runtimeInputs = [
                                inputs.mangowm.packages.${pkgs.stdenv.hostPlatform.system}.mango
                                self.packages.${pkgs.stdenv.hostPlatform.system}.launcher
                                pkgs.kitty
                                pkgs.playerctl
                                pkgs.wireplumber
                                pkgs.brightnessctl
                                pkgs.bibata-cursors
                        ];

                        flags = {
                                "-c" = toString ./mango/config.conf;
                        };
                };
        };
}
