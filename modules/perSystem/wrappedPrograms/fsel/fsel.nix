{ inputs, ... }: {
        perSystem = { pkgs, ... }: {
                packages.fsel = inputs.wrappers.lib.wrapPackage {
                        inherit pkgs;
                        package = inputs.fsel.packages.${pkgs.stdenv.hostPlatform.system}.default;
                        runtimeInputs = [
                                inputs.fsel.packages.${pkgs.stdenv.hostPlatform.system}.default
                        ];

                        flags = {
                                "--config" = toString ./config.toml;
                        };
                };
        };
}
