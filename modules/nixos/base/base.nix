{
        flake.nixosModules.base = { lib, ... }: {
                nix.settings.experimental-features = [ "nix-command" "flakes" ];
                nixpkgs.config = {
                        allowUnfree = true;
                        allowUnfreePredicate = _: true;
                };

                programs = {
                        nh = {
                                enable = true;
                                flake = lib.mkDefault "/etc/nixos";
                        };

                        gnupg.agent.enable = true;
                };
        };
}
