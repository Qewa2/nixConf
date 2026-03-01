{ inputs, ... }:{
        flake.nixosModules.base = {
                home-manager = {
                        extraSpecialArgs = { inherit inputs; };
                        useGlobalPkgs = true;
                        useUserPackages = true;
                };
        };
}
