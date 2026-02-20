{
        flake.nixosModules.base = { inputs, ... }: {
                home-manager = {
                        extraSpecialArgs = { inherit inputs; };
                        useGlobalPkgs = true;
                        useUserPackages = true;
                };
        };
}
