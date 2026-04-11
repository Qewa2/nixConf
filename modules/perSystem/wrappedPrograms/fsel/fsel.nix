{ inputs, ... }: {
        perSystem = { pkgs, ... }: {
                packages.fsel = inputs.wrappers.lib.wrapPackage {
                        inherit pkgs;
                        package = pkgs.fsel;
                        runtimeInputs = [
                                pkgs.fsel
                        ];

                        flags = {
                                "--config" = toString ./config.toml;
                        };
                };
        };
}
