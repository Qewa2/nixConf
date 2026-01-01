{
        inputs = {
                nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
                nvf.url = "github:NotAShelf/nvf";
        };

        outputs = { self, nixpkgs, nvf, ... }: {
                packages."x86_64-linux".configuredNvim =
                        (nvf.lib.neovimConfiguration {
                                pkgs = nixpkgs.legacyPackages."x86_64-linux";
                                modules = [ ./configuration.nix ];
                        }).neovim;

                packages."x86_64-linux".default = self.outputs.packages."x86_64-linux".configuredNvim;               
        };
}
