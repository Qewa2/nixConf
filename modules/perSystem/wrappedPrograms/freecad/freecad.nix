{ inputs, ... }: {
        perSystem = { pkgs, ... }: {
                packages.freecad = inputs.wrappers.lib.wrapPackage {
                        inherit pkgs;
                        package = pkgs.freecad;
                        runtimeInputs = [
                                pkgs.freecad
                        ];
                        
                        binName = "freecad";
                };
        };
}
