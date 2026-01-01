{
        inputs = {
                nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
                nvf.url = "github:NotAShelf/nvf";
        };

        outputs = { self, nixpkgs, nvf, ... }: {
                packages."x86_64-linux".default =
                        (nvf.lib.neovimConfiguration {
                                pkgs = nixpkgs.legacyPackages."x86_64-linux";
                                modules = [ ./configuration.nix ];
                        }).neovim;
                
#                nixosConfiguration.nixos = nixpkgs.lib.nixosSystem {
#                        modules = [
#                                nvf.nixosModules.default
#                        ];
#                };
        };
}
