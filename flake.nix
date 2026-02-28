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
                                (inputs.import-tree ./modules);
}
