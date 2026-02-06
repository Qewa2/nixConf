{
        description = "Nixos config flake";

        inputs = {
                nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

                home-manager = {
                        url = "github:nix-community/home-manager";
                        inputs.nixpkgs.follows = "nixpkgs";
                };

                stylix = {
                        url = "github:nix-community/stylix";
                        inputs.nixpkgs.follows = "nixpkgs";
                };

                awww.url = "git+https://codeberg.org/LGFae/awww";
                
                mango = {
                        url = "github:DreamMaoMao/mango";
                        inputs.nixpkgs.follows = "nixpkgs";
                };

                nvf  = {
                        url = "github:NotAShelf/nvf";
                        inputs.nixpkgs.follows = "nixpkgs";
                };

                flake-parts.url = "github:hercules-ci/flake-parts";

                import-tree.url = "github:vic/import-tree";
        };

        outputs = inputs:
                inputs.flake-parts.lib.mkFlake { inherit inputs; }
                        (
                                inputs.import-tree ./modules
                                inputs.import-tree ./hosts
                        );


        /*
        outputs = { self, nixpkgs, nvf, home-manager, stylix, mango, ... }@inputs: {
                nixosConfigurations = {
                        main = nixpkgs.lib.nixosSystem {
                                specialArgs = { inherit inputs; };
                                system = "x86_64-linux";
                                modules = [
                                        ./hosts/main/configuration.nix
                                        home-manager.nixosModules.home-manager
                                        nvf.nixosModules.default
                                        stylix.nixosModules.stylix
                                        mango.nixosModules.mango
                                ];
                        };
                        tailsNix = nixpkgs.lib.nixosSystem {
                                specialArgs = { inherit inputs; };
				system = "x86_64-linux";
				modules = [
					./hosts/tailsNix/configuration.nix
				];
                        };
                };
        };
        */
}
