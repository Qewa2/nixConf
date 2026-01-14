{
        description = "Nixos config flake";

        inputs = {
                nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

                home-manager = {
                        url = "github:nix-community/home-manager";
                        inputs.nixpkgs.follows = "nixpkgs";
                };

                awww.url = "git+https://codeberg.org/LGFae/awww";
                
                hyprland.url = "github:hyprwm/Hyprland";

                nvf  = {
                        url = "github:NotAShelf/nvf";
                        inputs.nixpkgs.follows = "nixpkgs";
                };
        };

        outputs = { self, nixpkgs, nvf, home-manager, ... }@inputs: {
                nixosConfigurations = {
                        main = nixpkgs.lib.nixosSystem {
                                specialArgs = { inherit inputs; };
                                system = "x86_64-linux";
                                modules = [
                                        ./hosts/main/configuration.nix
                                        home-manager.nixosModules.home-manager
                                        nvf.nixosModules.default
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
}
