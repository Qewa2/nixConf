{
        description = "Nixos config flake";

        inputs = {
                nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable-small";

                winit = {
                        url = "github:Qewa2/winit";
                        inputs.nixpkgs.follows = "nixpkgs";
                };

                home-manager = {
                        url = "github:nix-community/home-manager";
                        inputs.nixpkgs.follows = "nixpkgs";
                };

                stylix = {
                        url = "github:nix-community/stylix";
                        inputs.nixpkgs.follows = "nixpkgs";
                };

                awww.url = "git+https://codeberg.org/LGFae/awww";
                
                mangowm = {
                        url = "github:mangowm/mango";
                        inputs.nixpkgs.follows = "nixpkgs";
                };

                nvf  = {
                        url = "github:NotAShelf/nvf";
                        inputs.nixpkgs.follows = "nixpkgs";
                };

                otter-launcher.url = "github:kuokuo123/otter-launcher";

                fsel.url = "github:Mjoyufull/fsel";

                wrappers.url = "github:lassulus/wrappers";

                flake-parts.url = "github:hercules-ci/flake-parts";

                import-tree.url = "github:vic/import-tree";
        };

        outputs = inputs:
                inputs.flake-parts.lib.mkFlake { inherit inputs; }
                                (inputs.import-tree ./modules);
}
